From: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH] i2c: davinci: rename "i2c_recover_bus" function
Date: Fri, 5 Apr 2013 10:51:56 +0530
Message-ID: <515E5F74.5050505@ti.com>
References: <201304041354.30024.arnd@arndb.de> <CAKohpomq6YzfftrHEnx5gqxjK8bagaRZbH=e_f2ZaRVgAspHkw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAKohpomq6YzfftrHEnx5gqxjK8bagaRZbH=e_f2ZaRVgAspHkw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On 4/4/2013 7:37 PM, Viresh Kumar wrote:
> On 4 April 2013 19:24, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org> wrote:
>> As of commit 5f9296ba "i2c: Add bus recovery infrastructure", there
>> is now a global function with the same name, which clashes with
>> the davinci specific one. The obvious solution is to rename the
>> function with a davinci prefix.
>>
>> Signed-off-by: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
>> Cc: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>> Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>> Cc: davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
>> Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
>> Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
> 
> Acked-by: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> 
> But i believe this stuff should be updated to use the generic recovery
> infrastructure, as it is in now.
> 
> @Sekhar: Are you looking after it?

No, not in my plans ATM.

Thanks,
Sekhar
