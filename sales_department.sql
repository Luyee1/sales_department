-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 05, 2024 at 02:43 PM
-- Server version: 10.4.27-MariaDB
-- PHP Version: 8.1.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `sales_department`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `getcustomersales` (IN `CustomerID` VARCHAR(6))   Select invoicedetails.InvoiceID as Invoice, sum(TotalPrice_In_RM) as Sales
From customers
Join invoice on customers.CustomerID = invoice.CustomerID
Join invoicedetails on invoice.InvoiceID = invoicedetails.InvoiceID
where customers.CustomerID =CustomerID
group by invoicedetails.InvoiceID$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getsalesreport` (IN `EmployeeID` VARCHAR(6))   select employees.EmployeeID, FName,LName, count(invoicedetails.InvoiceID) as 'Total Invoice',sum(invoicedetails.TotalPrice_In_RM)  as 'Total Sales'
from employees
join customers on employees.EmployeeID = customers.EmployeeID
join invoice on customers.CustomerID = invoice.CustomerID
join invoicedetails on invoice.InvoiceID = invoicedetails.InvoiceID
where employees.EmployeeID =EmployeeID$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getyearsales` ()   SELECT year(InvoiceDate) AS Year,SUM(invoicedetails.TotalPrice_In_RM) AS AnnualRevenue
FROM invoice
JOIN invoicedetails ON invoice.InvoiceID = invoicedetails.InvoiceID
GROUP BY year(invoice.InvoiceDate)
ORDER BY year(invoice.InvoiceDate)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `month_year_sales` ()   Select year(InvoiceDate) as Year, month(InvoiceDate) as Month, count(InvoiceID) as InvoiceNum
From invoice
Group by year(InvoiceDate), month(InvoiceDate)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `showinvoiceqtymorethan` (IN `Quantity` INT)   SELECT InvoiceID, ProductID, invoicedetails.Quantity
FROM invoicedetails
WHERE invoicedetails.Quantity >=  Quantity 
ORDER BY InvoiceID$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `customers`
--

CREATE TABLE `customers` (
  `CustomerID` varchar(6) NOT NULL,
  `CustFName` varchar(20) DEFAULT NULL,
  `CustLName` varchar(20) DEFAULT NULL,
  `CustIC` varchar(14) DEFAULT NULL,
  `CustGender` varchar(6) DEFAULT NULL,
  `CustPhoneNum` varchar(15) DEFAULT NULL,
  `AddressLine1` varchar(50) DEFAULT NULL,
  `City` varchar(30) DEFAULT NULL,
  `PostalCode` char(6) DEFAULT NULL,
  `State` varchar(30) DEFAULT NULL,
  `Country` varchar(30) DEFAULT NULL,
  `EmployeeID` varchar(6) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `customers`
--

INSERT INTO `customers` (`CustomerID`, `CustFName`, `CustLName`, `CustIC`, `CustGender`, `CustPhoneNum`, `AddressLine1`, `City`, `PostalCode`, `State`, `Country`, `EmployeeID`) VALUES
('C0001', 'Johnny', 'Joe', '789212345671', 'Male', '455-555-5555', '123 Main St', 'Copenhagen', '123456', 'Capital Region of Denmark', 'Denmark', 'E0001'),
('C0002', 'Jenny', 'Smith', '989032545672', 'Female', '455-555-5556', '456 Park Ave', 'Sydney', '654321', 'New South Wales', 'Australia', 'E0002'),
('C0003', 'Bobby', 'John', '225060593821', 'Male', '455-555-5557', '789 Elm St', 'Kuala Lumpur', '789012', 'Federal Territory', 'Malaysia', 'E0003'),
('C0004', 'Sumanthiran', 'Williams', '272799152935', 'Male', '455-555-5558', '321 Oak St', 'Singapore', '321098', 'Central Region', 'Singapore', 'E0004'),
('C0005', 'Michael', 'Jones', '304265927257', 'Male', '455-555-5559', '654 Pine St', 'Berlin', '654789', 'Berlin', 'Germany', 'E0005'),
('C0006', 'David', 'Brown', '859365561471', 'Male', '455-555-5560', '987 Cedar St', 'Beijing', '987655', 'Beijing', 'China', 'E0006'),
('C0007', 'William', 'Miller', '313783325833', 'Male', '455-555-5561', '159 Birch St', 'Brasilia', '159753', 'Federal District', 'Brazil', 'E0007'),
('C0008', 'Ashley', 'Moore', '693170459989', 'Male', '455-555-5562', '753 Maple St', 'Tokyo', '753159', 'Tokyo', 'Japan', 'E0008'),
('C0009', 'Jessica', 'Taylor', '985643404556', 'Female', '455-555-5563', '951 Willow St', 'Seoul', '951357', 'Seoul', 'Korea', 'E0009'),
('C0010', 'Richard', 'Anderson', '890725595167', 'Male', '455-555-5564', '357 Elm St', 'New Delhi', '357951', 'Delhi', 'India', 'E0010'),
('C0011', 'Charles', 'Thomas', '706575959793', 'Male', '455-555-5565', '753 Oak St', 'Bogota', '753951', 'Cundinamarca', 'Colombia', 'E0011'),
('C0012', 'Matthew', 'Hernandez', '433512283891', 'Male', '455-555-5566', '951 Pine St', 'Rome', '951357', 'Lazio', 'Italy', 'E0012'),
('C0013', 'Joshua', 'Moore', '976764734101', 'Male', '455-555-5567', '357 Cedar St', 'Paris', '357951', 'Ile-de-France', 'France', 'E0013'),
('C0014', 'Daniel', 'Martin', '610113789153', 'Male', '455-555-5568', '753 Birch St', 'Buenos Aires', '753951', 'Buenos Aires', 'Argentina', 'E0014'),
('C0015', 'Andrew', 'Jackson', '795671050469', 'Male', '455-555-5569', '951 Maple St', 'Naypyidaw', '951357', 'Naypyidaw Union Territory', 'Myanmar', 'E0015'),
('C0016', 'Anthony', 'Thompson', '991051771150', 'Male', '455-555-5570', '357 Willow St', 'Moscow', '357951', 'Moscow', 'Russia', 'E0016'),
('C0017', 'Mary', 'Garcia', '528794878934', 'Female', '455-555-5571', '753 Elm St', 'Monrovia', '753951', 'Montserrado', 'Liberia', 'E0017'),
('C0018', 'Patricia', 'Martinez', '909954555416', 'Female', '455-555-5572', '951 Oak St', 'Doha', '951357', 'Ad Dawhah', 'Qatar', 'E0018'),
('C0019', 'Loo', 'Doe', '040593529025', 'Male', '455-555-5573', '123 Main St', 'Helsinki', '123456', 'Uusimaa', 'Finland', 'E0019'),
('C0020', 'Jane', 'Simpson', '543456451568', 'Female', '455-555-5574', '456 Park Ave', 'San Jose', '654321', 'San Jose', 'Costa Rica', 'E0020'),
('C0021', 'Chong', 'Eik Qiong', '548797398331', 'Male', '455-565-5355', '456 Main St', 'Copenhagen', '123456', 'Capital Region of Denmark', 'Denmark', 'E0001');

-- --------------------------------------------------------

--
-- Table structure for table `employees`
--

CREATE TABLE `employees` (
  `EmployeeID` varchar(6) NOT NULL,
  `FName` varchar(15) DEFAULT NULL,
  `LName` varchar(20) DEFAULT NULL,
  `EmployeeIC` varchar(14) DEFAULT NULL,
  `EmpGender` varchar(6) DEFAULT NULL,
  `Email` varchar(35) DEFAULT NULL,
  `EmpPhoneNum` varchar(15) DEFAULT NULL,
  `OfficeCode` varchar(6) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `employees`
--

INSERT INTO `employees` (`EmployeeID`, `FName`, `LName`, `EmployeeIC`, `EmpGender`, `Email`, `EmpPhoneNum`, `OfficeCode`) VALUES
('E0001', 'John', 'Doe', '123456789123', 'Male', 'johndoe@example.com', '555-555-5555', 'OFF01'),
('E0002', 'Jane', 'Smith', '234567891234', 'Female', 'janesmith@example.com', '555-555-5556', 'OFF01'),
('E0003', 'Bob', 'Johnson', '345678912345', 'Male', 'bobjohnson@example.com', '555-555-5557', 'OFF01'),
('E0004', 'Samantha', 'Williams', '456789123456', 'Female', 'samanthaw@example.com', '555-555-5558', 'OFF01'),
('E0005', 'Michael', 'Jones', '567891234567', 'Male', 'michaelj@example.com', '555-555-5559', 'OFF02'),
('E0006', 'David', 'Brown', '678912345679', 'Male', 'davidb@example.com', '555-555-5560', 'OFF02'),
('E0007', 'William', 'Miller', '789123456789', 'Male', 'williamm@example.com', '555-555-5561', 'OFF02'),
('E0008', 'Ashley', 'Moore', '891234567897', 'Male', 'ashleym@example.com', '555-555-5562', 'OFF02'),
('E0009', 'Jessica', 'Taylor', '91234567898', 'Female', 'jessicat@example.com', '555-555-5563', 'OFF03'),
('E0010', 'Richard', 'Anderson', '123456789011', 'Male', 'richarda@example.com', '555-555-5564 ', 'OFF03'),
('E0011', 'Charles', 'Thomas', '234567890123', 'Male', 'charles@example.com', '555-555-5565', 'OFF03'),
('E0012', 'Matthew', 'Hernandez', '345678901233', 'Male', 'matthew@example.com', '555-555-5566', 'OFF03'),
('E0013', 'Joshua', 'Moore', '456789012345', 'Male', 'joshua@example.com', '555-555-5567', 'OFF04'),
('E0014', 'Daniel', 'Martin', '567890123459', 'Male', 'daniel@example.com', '555-555-5568', 'OFF04'),
('E0015', 'Andrew', 'Jackson', '678901234567', 'Male', 'andrew@example.com', '555-555-5569', 'OFF04'),
('E0016', 'Anthony', 'Thompson', '789012345671', 'Male', 'anthony@example.com', '555-555-5570', 'OFF04'),
('E0017', 'Mary', 'Garcia', '890123456788', 'Female', 'mary@example.com', '555-555-5571', 'OFF05'),
('E0018', 'Patricia', 'Martinez', '901234567890', 'Female', 'patricia@example.com', '555-555-5572', 'OFF05'),
('E0019', 'Jennifer', 'Robinson', '012345670126', 'Female', 'jennifer@example.com', '555-555-5574', 'OFF05'),
('E0020', 'Linda', 'Clark', '123456789876', 'Female', 'linda@example.com', '555-555-5573', 'OFF05');

-- --------------------------------------------------------

--
-- Table structure for table `invoice`
--

CREATE TABLE `invoice` (
  `InvoiceID` varchar(6) NOT NULL,
  `InvoiceDate` date DEFAULT NULL,
  `CustomerID` varchar(6) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `invoice`
--

INSERT INTO `invoice` (`InvoiceID`, `InvoiceDate`, `CustomerID`) VALUES
('I-0001', '2022-01-01', 'C0001'),
('I-0002', '2022-01-01', 'C0002'),
('I-0003', '2022-02-01', 'C0003'),
('I-0004', '2022-02-01', 'C0004'),
('I-0005', '2022-03-01', 'C0005'),
('I-0006', '2022-04-01', 'C0006'),
('I-0007', '2022-05-01', 'C0007'),
('I-0008', '2022-06-01', 'C0008'),
('I-0009', '2022-07-01', 'C0009'),
('I-0010', '2022-08-01', 'C0010'),
('I-0011', '2022-08-01', 'C0011'),
('I-0012', '2022-09-01', 'C0012'),
('I-0013', '2022-09-01', 'C0013'),
('I-0014', '2022-09-01', 'C0014'),
('I-0015', '2022-09-01', 'C0015'),
('I-0016', '2022-09-01', 'C0016'),
('I-0017', '2022-09-01', 'C0017'),
('I-0018', '2022-10-01', 'C0018'),
('I-0019', '2022-10-01', 'C0019'),
('I-0020', '2022-11-01', 'C0020'),
('I-0021', '2022-12-02', 'C0021'),
('I-0022', '2022-12-03', 'C0021'),
('I-0023', '2023-01-01', 'C0001'),
('I-0024', '2023-01-02', 'C0001');

-- --------------------------------------------------------

--
-- Table structure for table `invoicedetails`
--

CREATE TABLE `invoicedetails` (
  `InvoiceID` varchar(6) DEFAULT NULL,
  `ProductID` varchar(6) DEFAULT NULL,
  `Quantity` int(11) DEFAULT NULL,
  `TotalPrice_In_RM` decimal(8,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `invoicedetails`
--

INSERT INTO `invoicedetails` (`InvoiceID`, `ProductID`, `Quantity`, `TotalPrice_In_RM`) VALUES
('I-0001', 'P0001', 1, '3599.00'),
('I-0001', 'P0002', 20, '64000.00'),
('I-0002', 'P0002', 2, '6400.00'),
('I-0003', 'P0003', 3, '9900.00'),
('I-0004', 'P0004', 4, '13600.00'),
('I-0005', 'P0005', 5, '17500.00'),
('I-0006', 'P0006', 6, '27600.00'),
('I-0007', 'P0007', 7, '25900.00'),
('I-0008', 'P0008', 8, '30400.00'),
('I-0009', 'P0009', 9, '35100.00'),
('I-0010', 'P0010', 10, '40000.00'),
('I-0011', 'P0011', 11, '45100.00'),
('I-0012', 'P0012', 12, '26400.00'),
('I-0013', 'P0013', 13, '55900.00'),
('I-0014', 'P0014', 14, '75600.00'),
('I-0015', 'P0015', 15, '112500.00'),
('I-0016', 'P0016', 16, '105600.00'),
('I-0017', 'P0017', 17, '96900.00'),
('I-0018', 'P0018', 18, '86400.00'),
('I-0019', 'P0019', 19, '74100.00'),
('I-0020', 'P0020', 20, '78000.00'),
('I-0021', 'P0001', 4, '14396.00'),
('I-0021', 'P0017', 5, '28500.00'),
('I-0022', 'P0002', 10, '32000.00'),
('I-0023', 'P0012', 10, '22000.00'),
('I-0024', 'P0013', 4, '17200.00');

--
-- Triggers `invoicedetails`
--
DELIMITER $$
CREATE TRIGGER `checkquantity` BEFORE INSERT ON `invoicedetails` FOR EACH ROW BEGIN
    DECLARE qty INT;
    SELECT StockQty INTO qty FROM products WHERE ProductID = NEW.ProductID;
    IF qty < NEW.Quantity THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Not enough stock quantity. Transaction rejects!';
    END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `updatebal` AFTER INSERT ON `invoicedetails` FOR EACH ROW update products
set StockQty = StockQty - New.Quantity
Where ProductID = New.ProductID
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `updatesum` BEFORE INSERT ON `invoicedetails` FOR EACH ROW set new.TotalPrice_In_RM = new.Quantity * (select Price_In_RM from products where products.ProductID = new.ProductID)
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `office`
--

CREATE TABLE `office` (
  `OfficeCode` varchar(6) NOT NULL,
  `OfficePhoneNum` varchar(15) DEFAULT NULL,
  `AddressLine1` varchar(50) DEFAULT NULL,
  `City` varchar(20) DEFAULT NULL,
  `PostalCode` char(6) DEFAULT NULL,
  `State` varchar(25) DEFAULT NULL,
  `Country` varchar(15) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `office`
--

INSERT INTO `office` (`OfficeCode`, `OfficePhoneNum`, `AddressLine1`, `City`, `PostalCode`, `State`, `Country`) VALUES
('OFF01', '111-111-1111', '123 Main St', 'Copenhagen', '10001', 'Capital Region of Denmark', 'Denmark'),
('OFF02', '111-111-1112', '234 Main St', 'Sydney', '90001', 'New South Wales', 'Australia'),
('OFF03', '111-111-1113', '345 Main St', 'Kuala Lumpur', '60601', 'Federal Territory', 'Malaysia'),
('OFF04', '111-111-1114', '456 Main St', 'Singapore', '77001', 'Central Region', 'Singapore'),
('OFF05', '111-111-1115', '789 Main St', 'Berlin', '85001', 'Berlin', 'Germany');

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `ProductID` varchar(6) NOT NULL,
  `ProductName` varchar(20) DEFAULT NULL,
  `Price_In_RM` decimal(7,2) DEFAULT NULL,
  `StockQty` int(11) DEFAULT NULL,
  `VendorID` varchar(6) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`ProductID`, `ProductName`, `Price_In_RM`, `StockQty`, `VendorID`) VALUES
('P0001', 'Apple iPhone 12', '3599.00', 195, 'V0001'),
('P0002', 'Samsung Galaxy S21', '3200.00', 88, 'V0002'),
('P0003', 'OnePlus 8T', '3300.00', 27, 'V0003'),
('P0004', 'Google Pixel 5', '3400.00', 136, 'V0004'),
('P0005', 'Sony Xperia 1 II', '3500.00', 45, 'V0005'),
('P0006', 'Huawei P40 Pro', '4600.00', 84, 'V0006'),
('P0007', 'LG V60 ThinQ', '3700.00', 43, 'V0007'),
('P0008', 'Xiaomi Mi 10T Pro', '3800.00', 92, 'V0008'),
('P0009', 'Oppo Find X2 Pro', '3900.00', 81, 'V0009'),
('P0010', 'Realme Narzo 30 Pro', '4000.00', 90, 'V0010'),
('P0011', 'Nokia 5.4', '4100.00', 59, 'V0011'),
('P0012', 'Vivo X51', '2200.00', 98, 'V0012'),
('P0013', 'ZTE Axon 30 Pro', '4300.00', 73, 'V0013'),
('P0014', 'Tecno Spark 6 Go', '5400.00', 26, 'V0014'),
('P0015', 'Razer Phone 3', '7500.00', 135, 'V0015'),
('P0016', 'Asus ROG Phone 5', '6600.00', 104, 'V0016'),
('P0017', 'BlackBerry KEY2', '5700.00', 58, 'V0017'),
('P0018', 'Ulefone Armor 9E', '4800.00', 72, 'V0018'),
('P0019', 'Cat S52', '3900.00', 71, 'V0019'),
('P0020', 'Nothing N4', '3900.00', 70, 'V0020');

-- --------------------------------------------------------

--
-- Table structure for table `vendors`
--

CREATE TABLE `vendors` (
  `VendorID` varchar(6) NOT NULL,
  `VendorName` varchar(20) DEFAULT NULL,
  `VendorContact` varchar(15) DEFAULT NULL,
  `VendorEmail` varchar(35) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `vendors`
--

INSERT INTO `vendors` (`VendorID`, `VendorName`, `VendorContact`, `VendorEmail`) VALUES
('V0001', 'Apple', '355-555-5555', 'Apple@example.com'),
('V0002', 'Samsung', '355-555-5556', 'Samsung@example.com'),
('V0003', 'OnePlus', '355-555-5557', 'OnePlus@example.com'),
('V0004', 'Google', '355-555-5558', 'Google@example.com'),
('V0005', 'Sony', '355-555-5559', 'Sony@example.com'),
('V0006', 'Huawei', '355-555-5560', 'Huawei@example.com'),
('V0007', 'LG', '355-555-5561', 'LG@example.com'),
('V0008', 'Xiaomi', '355-555-5562', 'Xiaomi@example.com'),
('V0009', 'Oppo', '355-555-5563', 'Oppo@example.com'),
('V0010', 'Realme', '355-555-5564', 'Realme@example.com'),
('V0011', 'Nokia', '355-555-5565', 'Nokia@example.com'),
('V0012', 'Vivo', '355-555-5566', 'Vivo@example.com'),
('V0013', 'ZTE', '355-555-5567', 'ZTE@example.com'),
('V0014', 'Tecno', '355-555-5568', 'Tecno@example.com'),
('V0015', 'Razer', '355-555-5569', 'Razer@example.com'),
('V0016', 'Asus', '355-555-5570', 'Asus@example.com'),
('V0017', 'BlackBerry', '355-555-5571', 'BlackBerry@example.com'),
('V0018', 'Ulefone', '355-555-5572', 'Ulefone@example.com'),
('V0019', 'Cat', '355-555-5573', 'Cat@example.com'),
('V0020', 'Nothing', '355-555-5574', '@Nothing@example.com');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `customers`
--
ALTER TABLE `customers`
  ADD PRIMARY KEY (`CustomerID`),
  ADD KEY `EmployeeID` (`EmployeeID`);

--
-- Indexes for table `employees`
--
ALTER TABLE `employees`
  ADD PRIMARY KEY (`EmployeeID`),
  ADD KEY `OfficeCode` (`OfficeCode`);

--
-- Indexes for table `invoice`
--
ALTER TABLE `invoice`
  ADD PRIMARY KEY (`InvoiceID`),
  ADD KEY `CustomerID` (`CustomerID`);

--
-- Indexes for table `invoicedetails`
--
ALTER TABLE `invoicedetails`
  ADD KEY `InvoiceID` (`InvoiceID`),
  ADD KEY `ProductID` (`ProductID`);

--
-- Indexes for table `office`
--
ALTER TABLE `office`
  ADD PRIMARY KEY (`OfficeCode`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`ProductID`),
  ADD KEY `VendorID` (`VendorID`);

--
-- Indexes for table `vendors`
--
ALTER TABLE `vendors`
  ADD PRIMARY KEY (`VendorID`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `customers`
--
ALTER TABLE `customers`
  ADD CONSTRAINT `customers_ibfk_1` FOREIGN KEY (`EmployeeID`) REFERENCES `employees` (`EmployeeID`);

--
-- Constraints for table `employees`
--
ALTER TABLE `employees`
  ADD CONSTRAINT `employees_ibfk_1` FOREIGN KEY (`OfficeCode`) REFERENCES `office` (`OfficeCode`) ON UPDATE CASCADE;

--
-- Constraints for table `invoice`
--
ALTER TABLE `invoice`
  ADD CONSTRAINT `invoice_ibfk_1` FOREIGN KEY (`CustomerID`) REFERENCES `customers` (`CustomerID`);

--
-- Constraints for table `invoicedetails`
--
ALTER TABLE `invoicedetails`
  ADD CONSTRAINT `invoicedetails_ibfk_1` FOREIGN KEY (`InvoiceID`) REFERENCES `invoice` (`InvoiceID`),
  ADD CONSTRAINT `invoicedetails_ibfk_2` FOREIGN KEY (`ProductID`) REFERENCES `products` (`ProductID`);

--
-- Constraints for table `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `products_ibfk_1` FOREIGN KEY (`VendorID`) REFERENCES `vendors` (`VendorID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
