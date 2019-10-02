From: Bjorn Ardo <bjorn.ardo@axis.com>
Subject: Re: [PATCH 1/2] i2c: slave-eeprom: initialize empty eeprom properly
Date: Wed, 2 Oct 2019 08:20:53 +0200
Message-ID: <150599be-9125-4ab9-e2a6-e792b41910e6@axis.com>
References: <20191001164009.21610-1-alpawi@amazon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191001164009.21610-1-alpawi@amazon.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Patrick Williams <alpawi@amazon.com>
Cc: =?UTF-8?B?QmrDtnJuIEFyZMO2?= <bjornar@axis.com>, Patrick Williams <patrick@stwcx.xyz>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Hi,


I sent in another patch earlier that added support for specifying a file 
in devicetree to initilize the eeprom from, corresponding to the case of 
pre-flashed eeprom. Maybe these two patches should be merged so this 
initialization is only done if no file is specified?


/BA

On 10/1/19 6:40 PM, Patrick Williams wrote:
> The i2c-slave-eeprom driver emulates at24 class eeprom devices,
> which come initialized with all 1s.  Do the same in the software
> emulation.
>
> Signed-off-by: Patrick Williams <alpawi@amazon.com>
> ---
>   drivers/i2c/i2c-slave-eeprom.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/drivers/i2c/i2c-slave-eeprom.c b/drivers/i2c/i2c-slave-eeprom.c
> index db9763cb4dae..efee56106251 100644
> --- a/drivers/i2c/i2c-slave-eeprom.c
> +++ b/drivers/i2c/i2c-slave-eeprom.c
> @@ -131,6 +131,8 @@ static int i2c_slave_eeprom_probe(struct i2c_client *client, const struct i2c_de
>   	if (!eeprom)
>   		return -ENOMEM;
>   
> +	memset(eeprom->buffer, 0xFF, size);
> +
>   	eeprom->idx_write_cnt = 0;
>   	eeprom->num_address_bytes = flag_addr16 ? 2 : 1;
>   	eeprom->address_mask = size - 1;
