// SPDX-License-Identifier: MIT
pragma solidity >0.6.0 <0.8.0;

pragma experimental ABIEncoderV2; // Enable experimental feature for returning dynamic arrays of structs

contract TaskManager {
    // Define an enumeration for user roles
    enum Role { Admin, Manager, Worker }
    
    // Define an enumeration for task statuses
    enum TaskStatus { Pending, InProgress, Completed }

    // Define a struct to represent a task
    struct Task {
        uint id;            // Unique identifier for the task
        address creator;    // Address of the user who created the task
        address assignee;   // Address of the user assigned to the task
        string title;       // Title of the task
        string description; // Description of the task
        uint deadline;      // Deadline for completing the task (timestamp)
        uint reward;        // Reward for completing the task
        bool verified;      // Flag indicating if the task has been verified
        TaskStatus status;  // Current status of the task
        uint priority;      // Priority of the task (0 - Low, 1 - Medium, 2 - High)
        string category;    // Category of the task
        uint[] dependencies; // Array of task IDs on which this task depends
    }

    Task[] public tasks;    // Array to store all tasks
    uint public nextTaskId; // ID for the next task to be created

    // Mapping to store user roles
    mapping(address => Role) public userRoles;

    // Mapping to store task access permissions
    mapping(uint => mapping(address => bool)) public taskAccess;

    // Events to log task-related actions
    event TaskCreated(uint indexed id, address indexed creator, string title);
    event TaskAssigned(uint indexed id, address indexed assignee);
    event TaskCompleted(uint indexed id, address indexed assignee);
    event TaskVerified(uint indexed id, address indexed verifier);

    // Modifier to restrict access to only admin users
    modifier onlyAdmin() {
        require(userRoles[msg.sender] == Role.Admin, "Only admin can perform this action");
        _;
    }

    // Modifier to restrict access to only manager users
    modifier onlyManager() {
        require(userRoles[msg.sender] == Role.Manager, "Only manager can perform this action");
        _;
    }

    // Modifier to restrict access to only worker users
    modifier onlyWorker() {
        require(userRoles[msg.sender] == Role.Worker, "Only worker can perform this action");
        _;
    }

    // Modifier to check if the task is not completed
    modifier taskNotCompleted(uint _taskId) {
        require(tasks[_taskId].status != TaskStatus.Completed, "Task is already completed");
        _;
    }

    // Modifier to check if the task is not verified
    modifier taskNotVerified(uint _taskId) {
        require(!tasks[_taskId].verified, "Task is already verified");
        _;
    }

    // Function to create a new task
    function createTask(
        string memory _title,
        string memory _description,
        uint _reward,
        uint _priority,
        string memory _category,
        uint[] memory _dependencies
    ) external {
        // Get the current block timestamp
        uint currentTime = block.timestamp;

        // Add one day (in seconds) to the current timestamp
        uint oneDayInSeconds = 24 * 60 * 60;
        uint futureDeadline = currentTime + oneDayInSeconds;

        // Create the task and push it to the tasks array
        tasks.push(Task(nextTaskId, msg.sender, address(0), _title, _description, futureDeadline, _reward, false, TaskStatus.Pending, _priority, _category, _dependencies));
        
        // Emit an event to log the creation of the task
        emit TaskCreated(nextTaskId, msg.sender, _title);
        
        // Increment the next task ID
        nextTaskId++;
    }

    // Function to assign a task to a user
    function assignTask(uint _taskId, address _assignee) external onlyManager {
        // Update the assignee and status of the task
        tasks[_taskId].assignee = _assignee;
        tasks[_taskId].status = TaskStatus.InProgress;
        
        // Emit an event to log the assignment of the task
        emit TaskAssigned(_taskId, _assignee);
    }

    // Function to update the status of a task
    function updateTaskStatus(uint _taskId, TaskStatus _status) external onlyWorker taskNotCompleted(_taskId) {
        // Update the status of the task
        tasks[_taskId].status = _status;
        
        // If the task is completed, emit an event to log it
        if (_status == TaskStatus.Completed) {
            emit TaskCompleted(_taskId, msg.sender);
        }
    }

    // Function to verify a completed task
    function verifyTask(uint _taskId) external onlyManager taskNotVerified(_taskId) {
        // Get the task
        Task storage task = tasks[_taskId];
        
        // Check if the task is completed and the verifier is authorized
        require(task.status == TaskStatus.Completed, "Task must be completed");
        require(taskAccess[_taskId][msg.sender], "Only authorized verifiers can verify this task");

        // Mark the task as verified
        task.verified = true;
        
        // Emit an event to log the verification of the task
        emit TaskVerified(_taskId, msg.sender);
    }

    // Function to get tasks assigned to or created by a user
    function getUserTasks(address _user) external view returns (Task[] memory) {
        // Initialize variables to store user tasks
        uint count = 0;
        for (uint i = 0; i < tasks.length; i++) {
            if (tasks[i].creator == _user || tasks[i].assignee == _user) {
                count++;
            }
        }
        Task[] memory userTasks = new Task[](count);
        uint index = 0;
        for (uint i = 0; i < tasks.length; i++) {
            if (tasks[i].creator == _user || tasks[i].assignee == _user) {
                userTasks[index] = tasks[i];
                index++;
            }
        }
        return userTasks;
    }

    // Function to grant access to verify a task
    function grantAccess(uint _taskId, address _user) external onlyAdmin {
        taskAccess[_taskId][_user] = true;
    }

    // Function to revoke access to verify a task
    function revokeAccess(uint _taskId, address _user) external onlyAdmin {
        taskAccess[_taskId][_user] = false;
    }

    // Function to set the role of a user
    function setRole(address _user, Role _role) external onlyAdmin {
        userRoles[_user] = _role;
    }
}
