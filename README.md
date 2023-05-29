# Notes
Creating this repo to quickly create & destroy aws resources for learning and experiment purposes

# Rules of Thumb
1. Don't use remote state import, instead, directly create data block that refers to resource name
1. Please use aws vault to smoothly use your own organization resources
1. Sensitive data should not be included, please ensure OOP is always used
