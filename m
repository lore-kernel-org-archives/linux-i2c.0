From: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH AUTOSEL 4.18 39/59] i2c: omap: Enable for ARCH_K3
Date: Thu, 22 Nov 2018 14:31:52 -0500
Message-ID: <20181122193152.GA9725@sasha-vm>
References: <20181114222335.99339-1-sashal@kernel.org>
 <20181114222335.99339-39-sashal@kernel.org>
 <779d8829-c90d-120a-5b7d-749c07d2a2ed@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <779d8829-c90d-120a-5b7d-749c07d2a2ed@ti.com>
Sender: stable-owner@vger.kernel.org
To: Vignesh R <vigneshr@ti.com>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Wolfram Sang <wsa@the-dreams.de>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

On Thu, Nov 15, 2018 at 10:05:02AM +0530, Vignesh R wrote:
>Hi,
>
>On 15/11/18 3:53 AM, Sasha Levin wrote:
>> From: Vignesh R <vigneshr@ti.com>
>>
>> [ Upstream commit 5b277402deac0691226a947df71c581686bd4020 ]
>
>This patch depends on c77245722fb4 ("arm64: Add support for TI's K3
>Multicore SoC architecture") which adds ARCH_K3 Kconfig symbol and
>merged to mainline in v4.19. Since I don't see c77245722fb4 in
>stable tree, please drop this commit from stable queues prior to v4.19
>(4.18, 4.14, 4.9, 4.4 and 3.18).

Dropped, thank you!
