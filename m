From: Neelesh Gupta <neelegup-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH] i2c: Driver to expose PowerNV platform i2c busses
Date: Thu, 13 Nov 2014 23:38:28 +0530
Message-ID: <5464F39C.8020700@linux.vnet.ibm.com>
References: <20141110060424.9407.2498.stgit@localhost.localdomain> <20141113075817.GA1288@katana> <1415876169.666.2.camel@kernel.crashing.org> <1415882455.666.4.camel@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1415882455.666.4.camel-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


On 11/13/2014 06:10 PM, Benjamin Herrenschmidt wrote:
> On Thu, 2014-11-13 at 21:56 +1100, Benjamin Herrenschmidt wrote:
>> No, there is no timeout, if that fails something went quite wrong, it
>> could almost be a BUG_ON (basically we passed a wrong token or a NULL
>> msg).
>>
>>>> +   }
>>>> +
>>>> +   rc = be64_to_cpu(msg.params[1]);
>>>> +   if (rc != OPAL_SUCCESS) {
>>>> +           rc = -EIO;
>>>> +           goto exit;
>>>> +   }
>>>> +
> Actually, to correct myself, there are a number of error conditions
> including timeouts inside the FW layer, but they are returned here, not
> from opal_async_wait_response(). So indeed, we could do some error code
> conversion at that point.
>
> Neelesh, can you do that on top of your patch that adds the detailed
> error codes ? We can merge it fw side tomorrow if you have a new spin,
> worst case if the FW is old and only returns OPAL_HARDWARE we return
> -EIO and if the FW is newer we'll have more precise error codes in Linux
> too.

Yes, nice to have more precise error codes so I'm adding them in firmware
and rolling out new version of the FW. Please look at it.

Thanks,
Neelesh

>
> Cheers,
> Ben.
>
>
