# P-NUT Counter App

A simple counter app 

## Description

This is a simple counter application which primarily does three operations viz, 1. Add 2. Substract 3. Reset. This application also has a memorizing power i.e it remembers the previous state of counter and displays it the next time u open the application. 
Also, if the application is kept open on multiple tabs. Changes value on one tab is reflected upon neighbouring tabs if we refresh once on those tabs once.

## Execution

To run the project one can install the latest version of flutter from their [doc](https://docs.flutter.dev/get-started/install). Then the following commands
1. flutter doctor
2. flutter config --enable-web
3. flutter pub get 
4. flutter run -d chrome (or, Simple press ctrl+f5 for windows)



Alternatively, if docker is installed on just run the following two commands from the root of the proj.:-
1. docker build -t [name] . (docker build -t counterapp .)
2. docker run -d -p 8080:80 --name [name] [name]


Now you should be ready to go 🚀




