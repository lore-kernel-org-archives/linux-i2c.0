From: Peter Rosin <peda@axentia.se>
Subject: Re: [RFC PATCH 2/2] i2c: mux: pca954x: verify the device id of the
 pca984x chips
Date: Mon, 5 Mar 2018 16:55:56 +0100
Message-ID: <eb97edc2-3a16-2931-2f19-a80a5ab4d88b@axentia.se>
References: <20180122113657.32094-1-peda@axentia.se>
 <20180122113657.32094-3-peda@axentia.se>
 <20180305155303.i4zut6wtwckdes7z@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180305155303.i4zut6wtwckdes7z@ninjato>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Adrian Fiergolski <adrian.fiergolski@cern.ch>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On 2018-03-05 16:53, Wolfram Sang wrote:
> 
>> @@ -97,59 +98,83 @@ static const struct chip_desc chips[] = {
>>  		.nchans = 2,
>>  		.enable = 0x4,
>>  		.muxtype = pca954x_ismux,
>> +		.id = { .manufacturer_id = I2C_DEVICE_ID_NONE },
> 
> Can't we just leave this empty and add a NULL pointer check below when
> testing for the device id?

Nope, it's not a pointer. I didn't think it should be, but maybe it
should? The drawback is that you have to create an extra variable
for each of the chips that do need an id, and I didn't fancy that...

Cheers,
Peter
