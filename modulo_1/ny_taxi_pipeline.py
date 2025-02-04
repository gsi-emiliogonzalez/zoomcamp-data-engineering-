import pandas as pd
from sqlalchemy import create_engine

# Leer el archivo Parquet
df = pd.read_csv('green_tripdata_2019-10.csv')

# Crear conexión a PostgreSQL
username = 'postgres'
password = 'postgres'
host = 'localhost'
port = '5432'
database = 'demo'
schema = 'public'
table_name = 'green_taxi_table'
engine = create_engine(f'postgresql+psycopg2://{username}:{password}@{host}:{port}/{database}')

try:
    # Generar el esquema de la tabla
    
    # Definir tamaño de cada bloque
    chunk_size = 100000
    total_rows = len(df)
    
    # Cargar en bloques
    for i, chunk in enumerate(range(0, total_rows, chunk_size)):
        df_chunk = df.iloc[chunk:chunk + chunk_size]
        
        df_chunk.to_sql(
            name='green_taxi_table',
            con=engine,
            if_exists='append' if i > 0 else 'replace',  # Reemplaza solo en el primer bloque
            index=False
        )
        
        print(f'✅ Chunk {i + 1} insertado: filas {chunk + 1} a {min(chunk + chunk_size, total_rows)}')

    print('🚀 Carga completada exitosamente.')

except Exception as e:
    print(f'❌ Error durante la carga: {e}')

# Mostrar el esquema generado
print('Done')
