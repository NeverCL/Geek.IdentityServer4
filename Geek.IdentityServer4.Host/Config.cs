using System.Collections.Generic;
using System.Security.Claims;
using IdentityServer4.Models;

namespace Geek.IdentityServer4.Host
{
    public class Config
    {
        public static IEnumerable<IdentityResource> GetIdentityResources()
        {
            return new List<IdentityResource>
            {
                new IdentityResources.OpenId(),
                new IdentityResources.Profile(),
            };
        }

        public static IEnumerable<ApiResource> GetApiResources()
        {
            return new List<ApiResource>
            {
                new ApiResource("api1", "My API", new []{ "name" }),
            };
        }

        public static IEnumerable<Client> GetClients()
        {
            return new List<Client>
            {
                new Client
                {
                    ClientId = "client",
                    AllowedGrantTypes = GrantTypes.ClientCredentials,
                    ClientSecrets =
                    {
                        new Secret("secret".Sha256())
                    },
                    Claims =
                    {
                        new Claim("name","客户端名称")
                    },
                    AllowedScopes = { "api1" }
                },
            };
        }
    }
}