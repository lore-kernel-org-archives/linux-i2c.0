From: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
Subject: Re: i2c-tools: add Android.mk
Date: Mon, 16 Mar 2015 10:16:26 +0100
Message-ID: <20150316101626.2c7a02be@endymion.delvare>
References: <CA+TH9VkQzJaSa0okxK+s1ukpaqgiWegh3uumEb63LzZwBjV4nA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CA+TH9VkQzJaSa0okxK+s1ukpaqgiWegh3uumEb63LzZwBjV4nA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Angelo Compagnucci <angelo.compagnucci-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Angelo,

On Fri, 27 Feb 2015 22:05:12 +0100, Angelo Compagnucci wrote:
> This patch adds an Android.mk to compile i2c-tools under Android.
> 
> Hope this helps!

I have to say I don't know what to do with this.

For one thing, I don't really understand why Android needs a separate
build mechanism when all other Linux and BSD incarnations seem to be
fine with the standard Makefile. GNU make certainly runs on Android,
right? And you would typically cross-compile for Android anyway. Also I
have not seen an Android.mk file in any other project I'm working on,
and I can't see why i2c-tools would be special in this respect.

For another, the current build mechanism is a modular one where the
main Makefile includes Module.mk files present in the different
subdirectories. I like this design and having a single Android.mk file
at the root of the project is inconsistent and breaks that design.

As a summary I don't see why anything special is needed for Android,
but if something like that is really needed then it should respect the
existing modular design.

Now if anyone has a more educated view on this than I do, please speak
up. Android is really not my thing (as a developer, I mean.)

Thanks,
-- 
Jean Delvare
SUSE L3 Support
