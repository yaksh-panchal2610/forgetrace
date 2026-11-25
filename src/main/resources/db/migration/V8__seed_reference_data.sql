INSERT INTO roles (role_name, description) VALUES
 ('BUYER',             'Creates RFQs, accepts quotations, tracks orders'),
 ('MANUFACTURER',      'Manages machines, quotes on RFQs, runs production'),
 ('QUALITY_INSPECTOR', 'Inspects batches and approves or rejects them'),
 ('ADMIN',             'Verifies organizations and manages the platform');

INSERT INTO manufacturing_processes (process_name, description) VALUES
 ('CNC Machining',      'Milling and turning of metal and plastic parts'),
 ('Laser Cutting',      'Precision cutting of sheet material'),
 ('Sheet Metal Fabrication', 'Bending, punching and forming of sheet metal'),
 ('Welding',            'MIG, TIG and arc welding of assemblies'),
 ('3D Printing',        'Additive manufacturing (FDM, SLA, SLS)'),
 ('Injection Moulding', 'High-volume plastic part production'),
 ('Casting',            'Sand and die casting of metal parts'),
 ('Powder Coating',     'Surface finishing and corrosion protection');

INSERT INTO materials (material_name, material_category, description) VALUES
 ('Mild Steel',        'Metal',   'General purpose low-carbon steel'),
 ('Stainless Steel 304', 'Metal', 'Corrosion resistant stainless steel'),
 ('Aluminium 6061',    'Metal',   'Lightweight structural aluminium'),
 ('Brass',             'Metal',   'Copper-zinc alloy'),
 ('Copper',            'Metal',   'High conductivity copper'),
 ('ABS',               'Plastic', 'Tough engineering plastic'),
 ('Nylon (PA6)',       'Plastic', 'Wear resistant engineering plastic'),
 ('Polycarbonate',     'Plastic', 'Impact resistant transparent plastic'),
 ('PLA',               'Plastic', '3D printing filament');