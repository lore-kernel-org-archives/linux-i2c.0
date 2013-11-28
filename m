From: Florian Meier <florian.meier@koalo.de>
Subject: Re: [PATCH] I2C: BCM2835: Linking platform nodes to adapter nodes
Date: Thu, 28 Nov 2013 09:56:22 +0100
Message-ID: <52970536.7040709@koalo.de>
References: <529303EE.4080606@koalo.de> <20131128085017.GC2626@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20131128085017.GC2626@katana>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Stephen Warren <swarren@wwwdotorg.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-rpi-kernel <linux-rpi-kernel@lists.infradead.org>, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Thank you very much!
I am sorry and will try to make it better next time.

On 11/28/2013 09:50 AM, Wolfram Sang wrote:
> On Mon, Nov 25, 2013 at 09:01:50AM +0100, Florian Meier wrote:
>> In order to find I2C devices in the device tree, the platform nodes
>> have to be known by the I2C core. This requires setting the
>> dev.of_node parameter of the adapter.
>>
>> Signed-off-by: Florian Meier <florian.meier@koalo.de>
> 
> Fixed up for you and applied to for-current. But PLEASE fix your mailer!
> 
