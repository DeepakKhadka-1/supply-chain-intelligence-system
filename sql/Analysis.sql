-- =========================================
-- SUPPLY CHAIN INTELLIGENCE SYSTEM
-- =========================================

-- ================================
-- 1. CREATE DATABASE
-- ================================
CREATE DATABASE supply_chain_db;
USE supply_chain_db;


-- ================================
-- 2. CREATE TABLE
-- ================================

CREATE TABLE supply_chain (
    product_type TEXT,
    sku TEXT,
    price FLOAT,
    availability INT,
    number_of_products_sold INT,
    revenue_generated FLOAT,
    customer_demographics TEXT,
    stock_levels INT,
    lead_times INT,
    order_quantities INT,
    shipping_times INT,
    shipping_carriers TEXT,
    shipping_costs FLOAT,
    supplier_name TEXT,
    location TEXT,
    lead_time INT,
    production_volumes INT,
    manufacturing_lead_time INT,
    manufacturing_costs FLOAT,
    inspection_results TEXT,
    defect_rates FLOAT,
    transportation_modes TEXT,
    routes TEXT,
    costs FLOAT,
    profit FLOAT,
    profit_margin FLOAT,
    cost_ratio FLOAT,
    inventory_risk TEXT,
    supplier_risk TEXT,
    shipping_cost_ratio FLOAT
);


-- ================================
-- 3. LOAD CSV (Table data import wizard)
-- ================================

-- ================================
-- 4. KPI OVERVIEW
-- ================================
SELECT 
    ROUND(SUM(revenue_generated),2) AS total_revenue,
    ROUND(SUM(costs),2) AS total_cost,
    ROUND(SUM(profit),2) AS total_profit,
    ROUND(AVG(profit_margin)*100,2) AS avg_profit_margin_pct
FROM supply_chain;


-- ================================
-- 5. TOP PRODUCTS
-- ================================
SELECT 
    product_type,
    SUM(revenue_generated) AS revenue,
    RANK() OVER (ORDER BY SUM(revenue_generated) DESC) AS product_rank
FROM supply_chain
GROUP BY product_type;


-- ================================
-- 6. SUPPLIER PERFORMANCE
-- ================================
SELECT 
    supplier_name,
    SUM(revenue_generated) AS revenue,
    AVG(defect_rates) AS defect_rate,
    RANK() OVER (ORDER BY SUM(revenue_generated) DESC) AS supplier_rank
FROM supply_chain
GROUP BY supplier_name;


-- ================================
-- 7. COST BY TRANSPORT MODE
-- ================================
SELECT 
    transportation_modes,
    SUM(shipping_costs) AS total_shipping_cost,
    ROUND(SUM(shipping_costs)*100.0 / SUM(SUM(shipping_costs)) OVER (),2) AS cost_pct
FROM supply_chain
GROUP BY transportation_modes;


-- ================================
-- 8. INVENTORY RISK DISTRIBUTION
-- ================================
SELECT 
    inventory_risk,
    COUNT(*) AS count,
    ROUND(COUNT(*)*100.0 / SUM(COUNT(*)) OVER (),2) AS percentage
FROM supply_chain
GROUP BY inventory_risk;


-- ================================
-- 9. HIGH RISK SUPPLIERS
-- ================================
SELECT 
    supplier_name,
    AVG(defect_rates) AS defect_rate
FROM supply_chain
GROUP BY supplier_name
HAVING AVG(defect_rates) > 0.05;


-- ================================
-- DONE
-- ================================