From: Michal Marek <mmarek-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: unmet direct dependencies in -next
Date: Mon, 10 Aug 2015 13:57:29 +0200
Message-ID: <55C891A9.2080607@suse.cz>
References: <55C71FF5.1020902@nod.at> <20150810091004.GC3249@x1>
 <55C86B66.3020601@nod.at> <55C88738.80400@suse.cz>
 <20150810115541.GA6479@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150810115541.GA6479@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Richard Weinberger <richard-/L3Ra7n9ekc@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-next-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, yann.morin.1998-GANU6spQydw@public.gmane.org, linux-kbuild <linux-kbuild-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "open list:I2C SUBSYSTEM" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, user-mode-linux-devel <user-mode-linux-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On 2015-08-10 13:55, Wolfram Sang wrote:
> 
>> The result of the given .config does not matter as much. The point of
>> the warnings is that there are missing select statements in the Kconfig
>> files.
> 
> For the I2C part, I think they should rather depend on I2C_MUX.
> Selecting I2C should be rare, like when you really need that PMIC to
> boot.

Right, that's another way to fix it.

Michal
