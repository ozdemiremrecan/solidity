// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

contract Todo{
    //Burda task'a ait değişkenleri tanımladım.
    struct Task{
        string content;
        bool isCompleted;
    }
    //Task türünden bir liste oluşturdum.
    Task[] public tasks;
    //Öncelikte task oluşturdum.
    function createTask(string memory _content) public{
        Task memory task;
        task.content=_content;
        task.isCompleted=false;
        tasks.push(task);
    }
    //Task'ı update ettim.
    function updateTask(string memory _content,uint _id)public{
        tasks[_id].content=_content;
    }
    //Listede bulunan bütün task'ları görüntüledim.
    function viewList()public view returns(Task[] memory){
        return tasks;
    }
    //Taskların işlerini düzenledim.
    function toggleTaskCompleted(uint _id) public{
        tasks[_id].isCompleted=!tasks[_id].isCompleted;
    }

}
