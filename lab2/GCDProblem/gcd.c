#include <stdio.h>
int main(void) {

	int firstnumber; //integer for first user inputted number
	int secondnumber; //integer for second user inputted number
	int helper; //integer is used to help carry out division/modulus operations as well as switching numbers
	int term = 1; // int is used to keep while loop running

	printf("Enter first positive term: "); //asks the user to input a number
	scanf("%d", &firstnumber); 
	printf("Enter second positive term: "); //asks the user to input one more number
	scanf("%d", &secondnumber); 

	if (firstnumber < secondnumber) { //checks if the first number is less than the second number and switches the numbers if this is the case
 		helper = secondnumber; // helper takes on the value of the second number
 		secondnumber = firstnumber; //secondnumber's value is replaced with firstnumber
 		firstnumber = helper; // firstnumber receives the value of the second number from helper
	}


	while (term == 1) { // while loop is used to find the GCD
 		helper = firstnumber % secondnumber; //helper takes on the value when finding the remainder of firstnumber/secondnumber
		if (helper == 0) { // checks if there is no remainder and the while loop is stopped if that's the case
 		break;
 		}	

 		else {
 		firstnumber = secondnumber; //firstnumber is changed to the value of secondnumber
 		secondnumber = helper; //secondnumber is changed to the remainder value
 		}

       }

	printf("The GCD is %d\n", secondnumber); //prints out the results
}