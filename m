From: Stefan Wahren <wahrenst@gmx.net>
Subject: Re: [PATCH V2 08/13] i2c: bcm2835: Avoid clk stretch quirk for BCM2711
Date: Sat, 17 Aug 2019 09:32:01 +0200
Message-ID: <bb924d04-b4a9-56c7-c7d5-31f3cc8c1da3@gmx.net>
References: <1565713248-4906-1-git-send-email-wahrenst@gmx.net>
 <1565713248-4906-9-git-send-email-wahrenst@gmx.net>
 <20190814193628.GA9756@kunai>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190814193628.GA9756@kunai>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>, Scott Branden <sbranden@broadcom.com>, Stephen Boyd <sboyd@kernel.org>, Ray Jui <rjui@broadcom.com>, Michael Turquette <mturquette@baylibre.com>, Eric Anholt <eric@anholt.net>, Rob Herring <robh+dt@kernel.org>, bcm-kernel-feedback-list@broadcom.com, linux-i2c@vger.kernel.org, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rpi-kernel@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram,

Am 14.08.19 um 21:36 schrieb Wolfram Sang:
>>  static const struct of_device_id bcm2835_i2c_of_match[] = {
>> -	{ .compatible = "brcm,bcm2835-i2c" },
>> +	{ .compatible = "brcm,bcm2711-i2c", .data = (void *)NO_STRETCH_BUG },
>> +	{ .compatible = "brcm,bcm2835-i2c", .data = (void *)STRETCH_BUG },
> What about simply putting a pointer to the quirks data (or NULL) as
> match_data? Then the code should be:
>
> adap->quirks = (cast)of_device_get_match_data(&pdev->dev);

quirks = (const struct i2c_adapter_quirks *)of_device_get_match_data(dev);

would hit the line limit. Do you insists on the cast, because it's
actually not required?
