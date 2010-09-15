From: Mike Rapoport <mike-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
Subject: Re: [PATCH] i2c-mv64xxx: use subsys_initcall for early	initialization
Date: Wed, 15 Sep 2010 15:43:08 +0200
Message-ID: <4C90CD6C.60100@compulab.co.il>
References: <1284284129-28105-1-git-send-email-mike@compulab.co.il> <20100914232547.GD7494@trinity.fluff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100914232547.GD7494-SMNkleLxa3Z6Wcw2j4pizdi2O/JbrIOy@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Ben Dooks wrote:
> On Sun, Sep 12, 2010 at 11:35:29AM +0200, Mike Rapoport wrote:
>> Signed-off-by: Mike Rapoport <mike-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
>> ---
>>  drivers/i2c/busses/i2c-mv64xxx.c |    2 +-
>>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> We really should have an i2c_initcall, but it may be difficult to move
> everyone over to it. What would be lovely is some form of dependency
> based initialisation, but that's probably a way off...

Yeah, that would be nice...

> I'll consider this for the next merge window.

Thanks

>> diff --git a/drivers/i2c/busses/i2c-mv64xxx.c b/drivers/i2c/busses/i2c-mv64xxx.c
>> index 1624206..6f3d084 100644
>> --- a/drivers/i2c/busses/i2c-mv64xxx.c
>> +++ b/drivers/i2c/busses/i2c-mv64xxx.c
>> @@ -592,7 +592,7 @@ mv64xxx_i2c_exit(void)
>>  	platform_driver_unregister(&mv64xxx_i2c_driver);
>>  }
>>  
>> -module_init(mv64xxx_i2c_init);
>> +subsys_initcall(mv64xxx_i2c_init);
>>  module_exit(mv64xxx_i2c_exit);
>>  
>>  MODULE_AUTHOR("Mark A. Greer <mgreer-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>");
> 


-- 
Sincerely yours,
Mike.
