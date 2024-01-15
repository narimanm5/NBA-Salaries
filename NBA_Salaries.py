import pandas as pd
stats_df = pd.read_csv("Seasons_Stats.csv")
stats_df.shape
filt = (stats_df["Year"] == 2017.0) | (stats_df["Year"] == 2018.0) 
df = stats_df.loc[filt].sort_values("Player").reset_index()
df.drop("Unnamed: 0",inplace=True,axis = 1)
df.index += 1
df.drop("index",inplace=True,axis = 1)
df
salaries = pd.read_csv("NBA_season1718_salary.csv")
salaries.sort_values("Player",inplace = True)
salaries.drop("Unnamed: 0",inplace=True,axis = 1)
salaries.reset_index(inplace = True)
salaries.index += 1
salaries.drop("index",inplace=True,axis = 1)
salaries
dups = df.duplicated(subset=['Player'],keep=False)
duplicates = df[dups]
filt = duplicates["Tm"] == "TOT"
dups1 = duplicates[filt]
df.drop_duplicates(subset=['Player'],keep=False,inplace=True)
df = pd.concat([df,dups1])
df = df.sort_values("Player").reset_index()
df
salaries = salaries.groupby('Player')['season17_18'].sum().reset_index()
salaries
dups = salaries.duplicated(subset=['Player'],keep=False)
salaries[dups]
stats = df
merged_df = pd.merge(salaries, stats, on='Player', how='left')
merged_df.dropna(axis=0,subset="Year",inplace = True)
merged_df
merged_df.drop("index",inplace=True,axis = 1)
merged_df.reset_index(inplace = True)
merged_df.index += 1
merged_df.drop("index",inplace=True,axis = 1)
merged_df
df = merged_df
df["PPG"] = df["PTS"]/df['G']
df["MPG"] = df["MP"]/df['G']
df["APG"] = df["AST"]/df['G']
df["RPG"] = df["TRB"]/df['G']
df["TOPG"] = df["TOV"]/df['G']
df["BPG"] = df["BLK"]/df['G']
df["SPG"] = df["STL"]/df['G']
df
df.to_excel("DF.xlsx")
