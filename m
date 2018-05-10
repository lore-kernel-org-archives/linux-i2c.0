From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH] i2c: i801: mark PM functions as __maybe_unused
Date: Thu, 10 May 2018 15:27:19 +0200
Message-ID: <20180510152719.6e37b10e@endymion>
References: <20180508073852.16840-1-anders.roxell@linaro.org>
        <20180509190055.61ad929b@endymion>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180509190055.61ad929b@endymion>
Sender: linux-kernel-owner@vger.kernel.org
To: Anders Roxell <anders.roxell@linaro.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Wed, 9 May 2018 19:00:55 +0200, Jean Delvare wrote:
> If SIMPLE_DEV_PM_OPS causes it but UNIVERSAL_DEV_PM_OPS did not, I
> suppose that what matters is CONFIG_PM_SLEEP.
> 
> So maybe we can just replace "#ifdef CONFIG_PM" with "ifdef
> CONFIG_PM_SLEEP" in the code below?

It seems that drivers i2c-brcmstb, i2c-mpc, i2c-ocores, i2c-pnx,
i2c-puv3, i2c-st, i2c-stu300 and i2c-mux-pca954x are doing exactly that
already, so that must be a valid way to solve the problem.

Will you send a new patch?

Thanks,
-- 
Jean Delvare
SUSE L3 Support
