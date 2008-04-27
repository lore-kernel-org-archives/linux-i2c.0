From: Jochen Friedrich <jochen@scram.de>
Subject: Re: [PATCH1/7] i2c: Add support for device alias names
Date: Sun, 27 Apr 2008 13:07:39 +0200
Message-ID: <48145E7B.6040805@scram.de>
References: <47FF70A7.5070002@scram.de> <20080426223815.16e38a85@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1760274AbYD0LGT@vger.kernel.org>
In-Reply-To: <20080426223815.16e38a85@hyperion.delvare>
Sender: linux-kernel-owner@vger.kernel.org
To: Jean Delvare <khali@linux-fr.org>
Cc: Kumar Gala <galak@kernel.crashing.org>, Scott Wood <scottwood@freescale.com>, "Kernel, Linux" <linux-kernel@vger.kernel.org>, linuxppc-dev list <linuxppc-dev@ozlabs.org>, Linux I2C <i2c@lm-sensors.org>, Jon Smirl <jonsmirl@gmail.com>, Laurent Pinchart <laurentp@cse-semaphore.com>
List-Id: linux-i2c@vger.kernel.org

Hi Jean,

>> -	if ((err = f75375_probe(client)) < 0)
>> +	err = f75375_probe(client, NULL);
>> +	if (err < 0)
>>  		goto exit_detach;
>>  
>>  	return 0;
> 
> These coding style cleanups don't belong to this patch (if they belong
> anywhere - I don't much see the point)

I just wanted to make sure, scripts/checkpatch.pl doesn't complain.
But you're right. The coding style cleanup should have been another patch.

Thanks a lot for your efforts of getting the alias stuff in!

Jochen
