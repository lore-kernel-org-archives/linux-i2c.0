From: =?ISO-8859-1?Q?Richard_R=F6jfors?=
	<richard.rojfors.lists-gfIc91nka+FZroRs9YW3xA@public.gmane.org>
Subject: Re: [PATCH] i2c-xii.c: Use OF instead of platform bus
Date: Tue, 18 May 2010 10:42:25 +0200
Message-ID: <4BF252F1.3090301@pelagicore.com>
References: <1274117574-1485-1-git-send-email-ricardo.ribalda@gmail.com> 	<4BF18D47.2030809@pelagicore.com> <AANLkTik9hCEhCFd9ku6m1SkTz45q6JwxxLUgBjLMOV-0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <AANLkTik9hCEhCFd9ku6m1SkTz45q6JwxxLUgBjLMOV-0-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ricardo Ribalda Delgado <ricardo.ribalda-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 05/17/2010 08:45 PM, Ricardo Ribalda Delgado wrote:
> Hello Richard
>
>    Sorry, I did not think in scenarios as you expose, what a strange
> device you have :). Let me be curious: what kind of bus is between the
> fpga (xps/plb) and the x86?

We use PCI express between the X86 and the FPGA, internally on the FPGA we have a PLB bus.

>
> Of course we can have a more flexible patch, let me think about the
> best (clean) way to implement it.

I did something similar to the xilinx_spi driver. It was OF only, I splitted it into a generic part, 
and OF part, and write a platform driver part.

--Richard
