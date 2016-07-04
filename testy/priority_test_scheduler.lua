--test_scheduler.lua
package.path = package.path..";../?.lua"

Scheduler = require("schedlua.scheduler")()
Task = require("schedlua.task")
local taskID = 0;

local function getNewTaskID()
	taskID = taskID + 1;
	return taskID;
end

--func is the function that is going to run,
--priority is MY ADDED PARAMETER for the priority level of the task
--for priority, high number = HIGH PRIORITY, range of priorities is 1-5
--5 is highest priority, 1 is lowest priority
-- ... is the parameters that func is going to take.
local function spawn(scheduler, func, priority, ...)
--MY CHANGE: passed priority level as parameter to scheduler
	local task = Task(func, ...)
	task.TaskID = getNewTaskID();
	scheduler:scheduleTask(task, {...}, priority);
	
	return task;
end


local function task1()
        print("first task, first line")
        Scheduler:yield();
        print("first task, second line")
        Scheduler:yield();
        print("first task, third line")
        Scheduler:yield();
        print("first task, fourth line")
        Scheduler:yield();
        print("first task, fifth line")
        Scheduler:yield();
        print("first task, sixth line")
end

local function task2()
        print("second task, first line")
        Scheduler:yield();
        print("second task, second line")
        Scheduler:yield();
        print("second task, third line")
        Scheduler:yield();
        print("second task, fourth line")
        Scheduler:yield();
        print("second task, fifth line")
        Scheduler:yield();
        print("second task, sixth line")
end

local function main()
--I ADDED: priority levels 3 and 1. 
--For this test to be successful, Level 3 should run faster than level 1.
	local t1 = spawn(Scheduler, task1, 3)
	local t2 = spawn(Scheduler, task2, 1)

	while (true) do
		--print("STATUS: ", t1:getStatus(), t2:getStatus())
		if t1:getStatus() == "dead" and t2:getStatus() == "dead" then
			break;
		end
		Scheduler:step()
	end
end

main()


