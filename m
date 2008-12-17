From: Dmitri Vorobiev <dmitri.vorobiev-WgUW+8SLYMv1KXRcyAk9cg@public.gmane.org>
Subject: Re: [PATCH 4/28] drivers/ide: Drop return value from	platform_driver
 remove functions
Date: Wed, 17 Dec 2008 14:49:46 +0200
Message-ID: <4948F56A.7020501@movial.fi>
References: <Pine.LNX.4.64.0812101727230.21998@ask.diku.dk> <20081216195734.GA8032@fluff.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20081216195734.GA8032-elnMNo+KYs3pIgCt6eIbzw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: Julia Lawall <julia-dAYI7NvHqcQ@public.gmane.org>, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kernel-janitors-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Ben Dooks wrote:
> On Wed, Dec 10, 2008 at 05:27:56PM +0100, Julia Lawall wrote:
>> From: Julia Lawall <julia-dAYI7NvHqcQ@public.gmane.org>
>>
>> The return value of the remove function of a driver structure, and thus of
>> a platform_driver structure, is ultimately ignored, and is thus
>> unnecessary.  This patch removes the return value for the remove function
>> stored in a platform_driver structure.
>>
>> For the files drivers/i2c/busses/i2c-at91.c and
>> drivers/i2c/busses/i2c-mv64xxx.c, the original return value was the value
>> of a variable storing the result of calling i2c_del_adapter.  I have thus
>> also deleted the declaration and initialization of this variable.  For the
>> other files, the return values were always 0.
>>
>> A simplified version of the semantic patch that makes this change is as
>> follows: (http://www.emn.fr/x-info/coccinelle/)
> 
> I take it remove_new will eventually be renamed to remove once all
> the changes have been made?
> 
> Unless there are any objections I'll add this to the merge list for
> the next window.

Please be careful since the drivers/base/ part has not been applied yet, so I'm Cc:ing Greg now for his opinion.

Dmitri
