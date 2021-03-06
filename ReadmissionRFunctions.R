
library(jsonlite)
library(httr)

getAuthToken <- function(user, password, auth){
  heads = c('Accept'='application/json','Content-Type'='application/x-www-form-urlencoded','Authorization'= paste("Basic ", auth,sep=''))
  fields <- list("grant_type"="password","username"=user, "password"= password)
  authReturn <- POST('http://sasserver.demo.sas.com/SASLogon/oauth/token', body=fields, add_headers(.headers = heads),encode = 'form',verbose())
  return(content(authReturn))
}

#getAuthToken('sasdemo', 'Orion123',base64_enc("restapp:testpw"))

# createRepository <- function(repoName,auth_token){
#   heads <- c('Accept'='application/json','Content-Type' = "application/vnd.sas.models.repository+json","Authorization"= paste("Bearer " , auth_token,sep=''))
#   print(heads)
#   repository <- list('name'= repoName)
#   print(repository)
#   myRepo <- POST(paste(viyahost , '/modelRepository/repositories',sep=''),body=repository, add_headers(.headers = heads),encode = 'form', verbose())
#   return(content(myRepo))
# }
# 
# createRepository <- function(repoName,auth_token){
#   heads <- c('Content-Type'='application/vnd.sas.models.repository+json',"Authorization"= paste("Bearer " , auth_token,sep=''))
#   myRepo <- POST(paste(viyahost , '/modelRepository/repositories',sep=''),
#                  add_headers(.headers = heads),
#                  body=paste('{"name":"', repoName,'"}',sep=''),
#                  encode = 'json'
#                  )
#   return(myRepo)
# }

executeREST <- function(endpoint,args,ctype,token){
  heads <- c('Accept'='application/json','Content-Type'=ctype,"Authorization"= paste("Bearer " , token,sep=''))
  results <- POST(endpoint,
                 add_headers(.headers = heads),
                 body=args,
                 encode = 'json'
                 #verbose()
  )
  return(results)
}

# 
# endpoint <- '/modelRepository/repositories'
# repoargs <-paste('{"name":"Test99txx1"}',sep='')
# 
# executeREST(endpoint,repoargs,logon_response$access_token)