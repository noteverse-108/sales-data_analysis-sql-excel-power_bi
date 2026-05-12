# Global Electronics Retailer — Sales Analysis Project

> End-to-end data analysis of a fictitious global electronics retailer using SQL, Excel, and Power BI.  
> Dataset sourced from the **Maven Analytics Data Playground**.

---

## Project Overview

This project performs a full-cycle business intelligence analysis on sales data from a fictitious global electronics retailer. The dataset spans multiple tables — transactions, products, customers, stores, and currency exchange rates — and covers everything from raw data cleaning through to interactive visual dashboards.

The goal is to surface actionable insights around revenue performance, customer behaviour, product trends, delivery efficiency, and channel differences (online vs. in-store), all presented through clean, stakeholder-ready visuals.

---

## Dataset

**Source:** Maven Analytics — Global Electronics Retailer  
**Tables included:**

| Table | Description |
|---|---|
| `Transactions` | Individual order-level sales records |
| `Products` | Product names, categories, subcategories, and cost/price |
| `Customers` | Customer demographics, location, and channel |
| `Stores` | Store locations, size, and open dates |
| `Exchange Rates` | Daily currency exchange rates for multi-currency normalization |

---

## Tools & Technologies

| Tool | Purpose |

| **SQL** | Data extraction, joining tables, aggregations, and business logic queries |
| **Microsoft Excel** | Data cleaning, validation, pivot analysis, and summary reporting |
| **Power BI** | Interactive dashboards, DAX measures, and trend visualizations |

---

## Workflow

### 1. Data Cleaning & Validation
- Identified and handled missing values across customer and transaction records
- Standardized date formats and currency fields
- Removed duplicate transaction entries
- Validated referential integrity across joined tables (e.g. products, stores, customers)
- Normalized revenue figures using exchange rate table for consistent USD-based analysis

### 2. SQL Analysis
- Queried total revenue, order volume, and average order value (AOV) by region, store, and product category
- Identified top-performing products and underperforming store locations
- Calculated delivery time (days between order date and delivery date) per order
- Segmented customers by channel (Online vs. In-Store) and geography
- Wrote aggregation queries to support seasonal trend analysis by month and quarter

### 3. Excel Analysis
- Built pivot tables for revenue by category, region, and time period
- Constructed summary sheets for KPIs: total revenue, total orders, AOV, and average delivery time
- Applied conditional formatting to highlight outliers and performance gaps
- Cross-validated SQL query outputs against raw data for accuracy

### 4. Power BI Dashboard
- Designed a multi-page interactive report covering:
  - **Revenue & Sales Trends** — monthly/quarterly line charts with year-over-year comparison
  - **Geographic Analysis** — choropleth map of customer distribution and revenue by country
  - **Product Performance** — treemap and bar charts by category and subcategory
  - **Delivery Analysis** — average delivery days over time; segmented by region and store type
  - **Channel Comparison** — online vs. in-store AOV, order volume, and revenue split
- Created DAX measures for dynamic KPIs, revenue difference calculations, and percentage comparisons
- Applied slicers for Country, Category, Channel, and Date Range for self-serve filtering

---

## Key Business Questions Answered

1. **What types of products does the company sell, and where are customers located?**  
   Electronics categories span computers, phones, cameras, and accessories. Customers are concentrated in North America and Europe, with emerging presence in Asia-Pacific.

2. **Are there seasonal patterns or trends in order volume or revenue?**  
   Clear Q4 spikes driven by holiday season demand, with a consistent dip in Q1. Year-over-year revenue growth is visible across most regions.

3. **Is there a difference in AOV for online vs. in-store sales?**  
   In-store transactions tend to carry a higher AOV, likely driven by high-value bundled purchases. Online orders are more frequent but lower in average value.

---

## Repository Structure

```
├── SQL/
│   ├── data_exploration.sql
│   ├── revenue_analysis.sql
│   ├── delivery_time.sql
│   └── customer_segmentation.sql
├── Excel/
│   ├── data_cleaning_log.xlsx
│   └── pivot_summary.xlsx
├── PowerBI/
│   └── global_electronics_dashboard.pbix
└── README.md
```

---

## Key Insights

- **Top revenue category:** Computers consistently generate the highest revenue share across all regions
- **Highest AOV channel:** In-store purchases average significantly higher order value than online
- **Strongest market:** North America leads in both order volume and total revenue
- **Delivery trend:** Average delivery time has decreased over the analysis period, indicating improving logistics
- **Seasonal peak:** November–December accounts for a disproportionate share of annual revenue

---

## How to Use This Project

1. **SQL scripts** — run against the raw CSV tables loaded into any SQL environment (PostgreSQL, MySQL, or SQL Server)
2. **Excel files** — open directly; pivot tables refresh automatically if source data is in the same folder
3. **Power BI report** — open `.pbix` in Power BI Desktop; update the data source path to your local CSV files and refresh

---

## Acknowledgements

Dataset provided by **Maven Analytics** as part of their free Data Playground.  
[https://www.mavenanalytics.io/data-playground](https://www.mavenanalytics.io/data-playground)

---

*Project by — Global Electronics Retailer Sales Analysis | SQL · Excel · Power BI*
