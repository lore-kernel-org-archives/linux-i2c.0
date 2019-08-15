From: Max Staudt <max@enpas.org>
Subject: Re: [PATCH v2 1/4] i2c/busses: Add i2c-icy for I2C on m68k/Amiga
Date: Thu, 15 Aug 2019 12:00:11 +0200
Message-ID: <276714fb-6b3a-1e99-0744-bfd037305724@enpas.org>
References: <20190812235237.21797-1-max@enpas.org>
 <20190814194714.GB9756@kunai>
 <f33ef44e-61e8-0392-7f5c-5a0bd7b42fff@enpas.org>
 <20190815071228.GA1054@kunai>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190815071228.GA1054@kunai>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, linux-hwmon@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>, Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, linux-m68k@vger.kernel.org, linux-kernel@vger.kernel.org, glaubitz@physik.fu-berlin.de
List-Id: linux-i2c@vger.kernel.org

On 08/15/2019 09:12 AM, Wolfram Sang wrote:
>> I kept it in because i2c-elektor also exposes it in the same way, and
>> it seems useful.
> 
> Yeah, I noticed. I don't know how useful it is in practice (same for the
> getown callback) but I don't have better ideas, so let's just keep this
> to be consistent.

Well, the other option is to remove it, and then add it back once somebody complains - which is unlikely to happen. The clock parameter is PCF8584 specific anyway, and  I think removing it is a good option, as I've done the same with getown() (where in i2c-elektor, 'own' sets the PCF8584's own address).

Question is, if I remove the parameter, I'd like it to be non-destructive. Do you know of anything that can go wrong if the I2C master is running the bus on a wrong clock?


Thanks

Max
