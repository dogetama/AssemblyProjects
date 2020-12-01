#include <stdio.h>

int main(void) { //main function 

	int firstnumber = 1; //1st int

	int secondnumber = 1; //2nd int
	
	int helper; //displays the fibonacci number

	int term; //the nth term entered by the user

 	printf("Enter Fibonacci term: "); //asks the user for fibonacci number

 	scanf("%d", &term); //gets the user input

	if(term < 3) { //checks if the term is smaller than 3
	
 		helper = 1; //sets the helper to one if term < 3

 	}

	else {
	
		for (int k = 0; k < term - 2; k++) { // a for loop is used to simulate the fibonacci sequence
 		
			helper = firstnumber + secondnumber; //helper is equaled to the addition of firstnumber and second number
 			secondnumber = firstnumber; //secondnumber is set to the value of firstnumber
 			firstnumber = helper; //firstnumber is set to the value of helper

		 }
 	}

 	printf("The %dth Fibonacci number is %d\n", term, helper); //prints out the value of helper
	
}