
# carecomm


## Overview
This Flutter project, named carecomm Assignment, is a mobile application designed to list products  and product details and add product to wishlist which is local using no sql database (hive) to manage this wishlist.  

## Features

- **Listing product**: View a list of product  with essential details about it like title and price.
- **Product details**: show product with more details .
- **WishList**: you can add new product  to you wishList and view it in wishlist route.


## Screenshots
![Screenshot_1738853451](https://github.com/user-attachments/assets/d726a0d9-635c-43a7-ba19-53c561cf614d)
![Screenshot_1738853479](https://github.com/user-attachments/assets/e8fc07c6-3fa1-4977-94ff-fb3f7ccbbecd)
![Screenshot_1739144230](https://github.com/user-attachments/assets/f1ce6a47-0837-4eac-8eba-ae54e42b600c)
![Screenshot_1739144245](https://github.com/user-attachments/assets/22c9ea60-5e4c-40b6-9b30-3e19d6391e3a)
![Screenshot_1739144250](https://github.com/user-attachments/assets/1d723926-8973-48c0-a143-aeacba2248b8)
![Screenshot_1739144258](https://github.com/user-attachments/assets/0a86f371-2f8c-48ed-a635-19dd43269038)



# carecomm

## Architecture

The HotelsGo Assignment project follows a clean and modular architecture, separating concerns to enhance maintainability and scalability. The architecture is inspired by the Flutter BLoC (Business Logic Component) pattern.

### Architecture Components

1. **Presentation Layer (UI):**
   - Widgets: Responsible for rendering the user interface.
   - Screens: Represent individual screens of the application.
   - controller(state management): Manage the presentation logic.

2. **Domian Layer (contract)**
   - Entitys: models of the data without serialization to the data.
   - BaseRepositories: it will be abstract class to be as contract between data and domain .
   - usecase: it only node which is connect to Presentation Layer.


3. **Data Layer:**
   - dataSource: Communicate with external APIs or databases.
   - Models: inherit from Entitys and make factory to serialized  the data return from API.
   - Repositories: implemantion to BaseRepositories to handle request from data source.

### Architecture Flow

![clean_Arch](https://github.com/user-attachments/assets/b9ce5d54-dc3a-4112-bbed-187362be3374)


*Clean Architecture With Flutter *


## Getting Started
Application in uploaded as web on vercel

https://carecommweb.vercel.app/#/product_page

Follow these steps to run the project locally:

1. Clone the repository:

   ```bash
   git clone https://github.com/MohamedAbdelbaky544/to_do_app.git

2. Navigate to the Project Directory:
  
   ```bash
   cd to_do_app

3. Install Dependencies:
  
   ```bash
   flutter pub get

4. Run the App:

   ```bash
   flutter run
