From: Mika Kuoppala <mika.kuoppala-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 0/1] Better i2c access latencies in high load situations
Date: Wed, 16 Sep 2009 15:08:55 +0300
Message-ID: <1253102935.13914.7.camel@adserver2>
References: <1253099829-17655-1-git-send-email-mika.kuoppala@nokia.com>
	 <20090916134944.4a329d62@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090916134944.4a329d62-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: ext Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: "ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Jean,

On Wed, 2009-09-16 at 13:49 +0200, ext Jean Delvare wrote:

> Can you please define "get a kick"? I don't know anything about
> rt_mutex.
> 

Sorry for using a vague metaphor. Documentation/rt-mutex.txt explains it
as:

"A low priority owner of a rt-mutex inherits the priority of a higher
priority waiter until the rt-mutex is released. If the temporarily
boosted owner blocks on a rt-mutex itself it propagates the priority
boosting to the owner of the other rt_mutex it gets blocked on. The
priority boosting is immediately removed once the rt_mutex has been
unlocked."

You might want to also take a look at Documentation/rt-mutex-design.txt

--Mika
