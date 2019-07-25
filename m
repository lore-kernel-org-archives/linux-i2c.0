From: Edward Cree <ecree@solarflare.com>
Subject: Re: [PATCH] net: sfc: falcon: convert to i2c_new_dummy_device
Date: Thu, 25 Jul 2019 13:37:57 +0100
Message-ID: <72968faa-e260-3640-99be-9c63bc79ad5e@solarflare.com>
References: <20190722172635.4535-1-wsa+renesas@sang-engineering.com>
 <20190724.154739.72147269285837223.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190724.154739.72147269285837223.davem@davemloft.net>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: David Miller <davem@davemloft.net>, wsa+renesas@sang-engineering.com
Cc: linux-i2c@vger.kernel.org, linux-net-drivers@solarflare.com, mhabets@solarflare.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On 24/07/2019 23:47, David Miller wrote:
> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Date: Mon, 22 Jul 2019 19:26:35 +0200
>
>> Move from i2c_new_dummy() to i2c_new_dummy_device(). So, we now get an
>> ERRPTR which we use in error handling.
>>
>> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Subject & description are incomplete, you're also changing i2c_new_device()
 to i2c_new_client_device().
Other than that,
Acked-by: Edward Cree <ecree@solarflare.com>

> Solarflare folks, please review/test.
>
> Thank you.
Falcon isn't likely to get tested by us, I think we only have about three
 of them left in the building, two of which are in display cabinets ;-)
We end-of-lifed this hardware a couple of years ago, maybe it should be
 downgraded from 'supported' to 'odd fixes'.  Or even moved to staging,
 like that qlogic driver recently was.
