From: Peter Rosin <peda@axentia.se>
Subject: Re: [RFC PATCH 1/2] i2c: add i2c_get_device_id() to get the standard
 i2c device id
Date: Mon, 5 Mar 2018 17:06:47 +0100
Message-ID: <b624a0c7-ffe2-245b-ff9e-ca9d10063715@axentia.se>
References: <20180122113657.32094-1-peda@axentia.se>
 <20180122113657.32094-2-peda@axentia.se>
 <20180305155111.ihlt4hn4yz3igo3z@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180305155111.ihlt4hn4yz3igo3z@ninjato>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Adrian Fiergolski <adrian.fiergolski@cern.ch>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On 2018-03-05 16:51, Wolfram Sang wrote:
> On Mon, Jan 22, 2018 at 12:36:56PM +0100, Peter Rosin wrote:
>> Can be used during probe to double check that the probed device is
>> what is expected.
>>
>> Loosely based on code from Adrian Fiergolski <adrian.fiergolski@cern.ch>.
>>
>> Signed-off-by: Peter Rosin <peda@axentia.se>
> 
> In general, nice! I wanted to have such a function in the core but never
> had a device to test it with. So, much appreciated.
> 
> Looks mostly good, except...
> 
>> +	ret = i2c_smbus_xfer(adap, I2C_ADDR_DEVICE_ID, client->flags,
> 
> We shouldn't pass the flag of the clients (like PEC) here. I'd think it
> could be plain 0 but please double-check.

Right,
..._TEN should definitely be cleared.
..._SLAVE will probably be cleared anyway.
..._HOST_NOTIFY, ..._WAKE and ..._SCCB I don't know about?

Are there others? The bits aren't that densely populated which makes
me worry that I'm missing something...

Cheers,
Peter

>> +/**
>> + * struct i2c_device_identity - i2c client device identification
>> + * @manufacturer_id: 0 - 4095, database maintained by NXP
>> + * @part_id: 0 - 511, according to manufacturer
>> + * @die_revision: 0 - 7, according to manufacturer
>> + */
> 
> All is nicely documented, very good!
> 
> About the upstreaming procedure: Could you just make a seperate
> pull-request out of this feature? I'll pull that in to have it in my
> tree and you can still collect patches in your usual for-next branch.
> 
> When the above is fixed you can add my:
> 
> Reviewed-by: Wolfram Sang <wsa@the-dreams.de>
> 
