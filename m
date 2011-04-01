From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [PATCH] NFC: Driver for Inside Secure MicroRead NFC chip
Date: Fri, 1 Apr 2011 21:43:23 +0200
Message-ID: <201104012143.23261.arnd@arndb.de>
References: <1300444824-13713-1-git-send-email-waldemar.rymarkiewicz@tieto.com> <20110331153010.GD2704@sortiz-mobl> <AANLkTikjTAFrhS7_P+KJ-r-33K6fW2+63OnLhjXE-u0k@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <AANLkTikjTAFrhS7_P+KJ-r-33K6fW2+63OnLhjXE-u0k-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Aloisio Almeida <aloisio.almeida-430g2QfJUUCGglJvpFV4uA@public.gmane.org>
Cc: Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Waldemar.Rymarkiewicz-++hxYGjEMp0AvxtiuMwx3w@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, hthebaud-Umy9UjvE/gtWk0Htik3J/w@public.gmane.org, matti.j.aaltonen-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org, alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org, Sebastian.Chlad-++hxYGjEMp0AvxtiuMwx3w@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Friday 01 April 2011 20:19:30 Aloisio Almeida wrote:
> We are finalizing a NFC stack prototype and we decided to use generic
> netlink. But during the implementation we found a disadvantage of this
> approach.
> 
> While implementing data_exchange through netlink, it was not possible
> to avoid memcpy as the skbuff coming from netlink can contain more
> than one message.

I don't think anyone in this thread suggested using netlink for user
data.

> We didn't find any implementation that uses netlink to exchage data.
> As in the nl80211, the netlink is used only for control commands.

Yes, that is the normal way to do it.
 
> We plan to publish for comments this prototype early next week. Then
> we plan to implement a version using AF_NFC.

Sounds good.
	
	Arnd
