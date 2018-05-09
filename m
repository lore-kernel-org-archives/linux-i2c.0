From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH] i2c: i801: mark PM functions as __maybe_unused
Date: Wed, 9 May 2018 19:00:55 +0200
Message-ID: <20180509190055.61ad929b@endymion>
References: <20180508073852.16840-1-anders.roxell@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180508073852.16840-1-anders.roxell@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Anders Roxell <anders.roxell@linaro.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Hi Anders,

On Tue,  8 May 2018 09:38:52 +0200, Anders Roxell wrote:
> With CONFIG_PM, we get a harmless build warning:
> drivers/i2c/busses/i2c-i801.c:1723:12: warning: ‘i801_resume’ defined but not used [-Wunused-function]
>  static int i801_resume(struct device *dev)
>             ^~~~~~~~~~~
> drivers/i2c/busses/i2c-i801.c:1714:12: warning: ‘i801_suspend’ defined but not used [-Wunused-function]
>  static int i801_suspend(struct device *dev)
>             ^~~~~~~~~~~~

I have CONFIG_PM=y and I don't get this warning, even with W=1. Which
gcc version are you using, which exact kernel version are you building,
and what is the value of all the CONFIG_PM_* options?

> This marks the affected functions as __maybe_unused.

I'm not a big fan of __maybe_unused, at least not in this specific
situation. We should be able to know exactly when these functions are
needed, and only include them when this is the case. Building unused
code just to discard it later (hopefully?) is a waste of CPU time.

> 
> Fixes: a9c8088c7988 ("i2c: i801: Don't restore config registers on runtime PM")

If SIMPLE_DEV_PM_OPS causes it but UNIVERSAL_DEV_PM_OPS did not, I
suppose that what matters is CONFIG_PM_SLEEP.

So maybe we can just replace "#ifdef CONFIG_PM" with "ifdef
CONFIG_PM_SLEEP" in the code below?

> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> ---
>  drivers/i2c/busses/i2c-i801.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
> index ed07f9002710..ff18c6ed2bec 100644
> --- a/drivers/i2c/busses/i2c-i801.c
> +++ b/drivers/i2c/busses/i2c-i801.c
> @@ -1711,7 +1711,7 @@ static void i801_shutdown(struct pci_dev *dev)
>  }
>  
>  #ifdef CONFIG_PM
> -static int i801_suspend(struct device *dev)
> +static int __maybe_unused i801_suspend(struct device *dev)
>  {
>  	struct pci_dev *pci_dev = to_pci_dev(dev);
>  	struct i801_priv *priv = pci_get_drvdata(pci_dev);
> @@ -1720,7 +1720,7 @@ static int i801_suspend(struct device *dev)
>  	return 0;
>  }
>  
> -static int i801_resume(struct device *dev)
> +static int __maybe_unused i801_resume(struct device *dev)
>  {
>  	struct pci_dev *pci_dev = to_pci_dev(dev);
>  	struct i801_priv *priv = pci_get_drvdata(pci_dev);


-- 
Jean Delvare
SUSE L3 Support
