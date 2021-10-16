extends Control

var penis: int

func _ready():
	penis = 4
	$SetUp/LeaveButton.hide()

func host_room():
	pass
	
func join_room():
	pass

func enter_room():
	$SetUp/LeaveButton.show()
	$SetUp/JoinButton.hide()
	$SetUp/HostButton.hide()
	$SetUp/IpEnter.hide()
	
func leave_room():
	$SetUp/LeaveButton.hide()
	$SetUp/JoinButton.show()
	$SetUp/HostButton.show()
	$SetUp/IpEnter.show()


func _on_HostButton_button_up():
	host_room()


func _on_JoinButton_button_up():
	enter_room()


func _on_LeaveButton_button_up():
	leave_room()
