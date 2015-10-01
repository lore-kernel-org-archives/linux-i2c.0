From: Kieran Bingham <kieranbingham@gmail.com>
Subject: Re: [RESEND PATCH v4 0/8] i2c: Relax mandatory I2C ID table passing
Date: Thu, 1 Oct 2015 22:10:57 +0100
Message-ID: <CAB3z_RpmZsxL6=UiYf7s2BM_OSKUkd0vOJ7GxVER-oh+=XhK+w@mail.gmail.com>
References: <1441972564-9621-1-git-send-email-kieranbingham@gmail.com>
	<55FAE058.7080504@osg.samsung.com>
	<20150920041528.GA3039@x1>
	<5603A881.2010300@osg.samsung.com>
	<20150924165807.GA27197@x1>
	<20151001205035.GB7514@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-la0-f45.google.com ([209.85.215.45]:36609 "EHLO
	mail-la0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750785AbbJAVK7 (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Thu, 1 Oct 2015 17:10:59 -0400
In-Reply-To: <20151001205035.GB7514@katana>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Lee Jones <lee.jones@linaro.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Samuel Ortiz <sameo@linux.intel.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Grant Likely <grant.likely@linaro.org>

Hi Wolfram,

On 1 October 2015 at 21:50, Wolfram Sang <wsa@the-dreams.de> wrote:
>
>> > Yes but that is not true for drivers that support both OF and legacy board
>> > files. For those drivers, there will be a lot of boiler plate code duplicated
>> > that would look something like:
>> >
>> >      unsigned long data;
>> >      struct of_device_id *match;
>> >      struct i2c_devicd_id *id;
>> >
>> >      if (i2c->dev.of_node) {
>> >             match = i2c_of_match_device(of_match_table, i2c);
>> >         if (!match)
>> >                return -EINVAL;
>> >
>> >             data = (unsigned long)match->data;
>> >      } else {
>> >             id = i2c_match_id(id_table, i2c);
>> >         if (!id)
>> >                return -EINVAL;
>> >
>> >             data = id->driver_data;
>> >      }
>
> I said this before: It is not only the additional code, I think it is
> quite unelegant to to do the matching again which has already been done.
> (and DT boottime has already increased, partly due to the excessive
> string matching). Also, I wouldn't like to see an I2C specific solution;
> this problem exists for other subsystems, too.
>
>> I'm fine with a new API for this stuff.  I'm even happy to go ahead
>> and code it up, but it's important to note that this is work which
>> should be based on this set and not a blocker for this set to be
>> accepted.
>
> Is that a promise? :)

Well if Lee doesn't, then I'll be trying to take it on.
I've already written an spatch to help with the conversion of other
drivers to follow on for this series.

Between us I think we've got motivation to make progress.

>> The correct approach is the former.  One of the aims of this set was
>> to bring the I2C .probe() call-back more into line with the majority
>> of the other .probe() calls in the kernel i.e. with only a single
>> parameter.  I'm really not a fan of passing some random void pointer
>
> Yes, I like this about this series.
>
>> in.  Using a look-up call to fetch ACPI/OF/I2C/etc data is the current
>> norm and is a very viable option.
>
> It is the status quo, but that doesn't make it better IMO.
>
>> Wolfram, please (finally :D) take this set.
>
> I tend to give in ;) Maybe we can talk in Dublin a bit about a possible
> next step after this series?

I don't think Lee is coming to Dublin, but I'll be there all week, if
you find time for a chat.
I'll look out for you in the hallway track, or at least on stage for
the final ELCE games :)

>
> Thanks,
>
>    Wolfram
>

--
Regards

Kieran
