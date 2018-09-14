
library(jsonlite)
library(httr)



getAuthToken <- function(url, user, password, auth){
  heads = c('Accept'='application/json','Content-Type'='application/x-www-form-urlencoded','Authorization'= paste("Basic ", auth,sep=''))
  fields <- list("grant_type"="password","username"=user, "password"= password)
  authReturn <- POST(paste(url,'/SASLogon/oauth/token',sep=''), body=fields, add_headers(.headers = heads),encode = 'form',verbose())
  return(content(authReturn))#.json()['access_token']
}


createRepository <- function(repoName,auth_token){
  heads = c('Content-Type' = "application/vnd.sas.models.repository+json","Authorization"= paste("Bearer " , auth_token[1],sep=''))
  print(heads)
  repository = list('name'= repoName)
  print(repository)
  myRepo = POST(paste(viyahost , '/modelRepository/repositories',sep=''), data=toJSON(repository), add_headers(.headers = heads),encode = 'json', verbose())
  return(myRepo)
}

createRepository('testRrepoxss',logon_response$access_token)