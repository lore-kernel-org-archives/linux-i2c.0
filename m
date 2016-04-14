From: Thilo Cestonaro <thilo@cestona.ro>
Subject: Re: [PATCH] i2c-i801: use MEM resource instead of IO resource
Date: Thu, 14 Apr 2016 16:27:46 +0200
Message-ID: <2dc87fd6667922a37d15dbe63d6286e9@cestona.ro>
References: <4b887e81aae134c2cfea3e8bb0443c7d@cestona.ro>
 <1460444562.5044.3.camel@chaos.suse>
 <fd8747be64462b1708964249beb834da@cestona.ro>
 <1460530884.4106.10.camel@chaos.suse>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from smtp.cestona.ro ([85.10.192.88]:51969 "EHLO smtp.cestona.ro"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755243AbcDNO1s (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Thu, 14 Apr 2016 10:27:48 -0400
In-Reply-To: <1460530884.4106.10.camel@chaos.suse>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jean Delvare <jdelvare@suse.com>
Cc: linux-i2c@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>

> The reason why we made acpi_enforce_resources=strict the default is so
> that the awareness of the problem grows, and BIOS vendors finally start
> caring about it. And it starts working, after many years, see:
> 
> https://bugzilla.kernel.org/show_bug.cgi?id=110041
> 
> If Intel starts caring then maybe we'll see better BIOSes in the 
> future.
> They provide the reference BIOS to board makers as far as I know.

I like that you hope Intel will react on this one day :).

> 
> So I'm not taking your patch, sorry. Doing so would break the whole
> plan.

I see, no problem with this.

Cheers,
Thilo
