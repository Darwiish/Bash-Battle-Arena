#!/bin/bash

# ===============================
# System Tasks Menu Script
# ===============================

# Pause function to wait for user before returning to menu
pause() {
	echo
	read -p "Press Enter to continue..."
}

# Function to display disk space
check_disk_space() {
	echo "===== Disk Space ====="
	df -h
	echo "======================"
}

# Function to show system uptime
show_uptime() {
	echo "===== System Uptime ====="
	uptime -p
	echo "========================="
}

# Function to list logged-in users
list_users() {
	echo "===== Logged-in Users ====="
	who
	echo "==========================="
}

# Function to display the menu and handle user input
menu() {
	while true; do
		clear
		echo "===== SYSTEM TASKS MENU ====="
		echo "1) Check disk space"
		echo "2) Show system uptime"
		echo "3) List users"
		echo "4) Quit"
		echo "=============================="

		# Read user input
		read -p "Enter your choice [1-4]: " choice

		# Execute based on user choice
		case "$choice" in
		1)
			check_disk_space
			pause
			;;
		2)
			show_uptime
			pause
			;;
		3)
			list_users
			pause
			;;
		4)
			echo "Goodbye!"
			break
			;;
		*)
			echo "Invalid option! Please select a valid number (1-4)."
			sleep 1
			;;
		esac
	done
}

# Run the menu function
menu
