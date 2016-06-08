From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v4 1/2] i2c: qup: add ACPI support
Date: Wed, 08 Jun 2016 23:02:00 +0200
Message-ID: <4749471.m1cxc4jj96@wuerfel>
References: <1465409985-17113-1-git-send-email-austinwc@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1465409985-17113-1-git-send-email-austinwc@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Austin Christ <austinwc@codeaurora.org>, wsa@the-dreams.de, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, timur@codeaurora.org, rruigrok@codeaurora.org, nkaje@codeaurora.org, cov@codeaurora.org
List-Id: linux-i2c@vger.kernel.org

On Wednesday, June 8, 2016 12:19:44 PM CEST Austin Christ wrote:
> +               ret = device_property_read_u32(qup->dev,
> +                               "src-clock-hz", &src_clk_freq);
> +               if (ret) {
> +                       dev_warn(qup->dev, "using default src-clock-hz %d",
> +                               DEFAULT_SRC_CLK);
> +                       src_clk_freq = DEFAULT_SRC_CLK;
> +               }
> 

Where is this property documented?

	Arnd
