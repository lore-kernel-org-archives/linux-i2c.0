From: Joel Stanley <joel@jms.id.au>
Subject: Re: [PATCH v12 8/8] MAINTAINERS: Add Eddie as the maintainer for the
 FSI-attached I2C driver
Date: Thu, 19 Jul 2018 14:15:25 +0930
Message-ID: <CACPK8Xfa5Q7EiU65fhZn1Lnghq+j+kc+-_+ejheSjF-OzyKNrw@mail.gmail.com>
References: <1531841466-9833-1-git-send-email-eajames@linux.vnet.ibm.com> <1531841466-9833-9-git-send-email-eajames@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1531841466-9833-9-git-send-email-eajames@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Eddie James <eajames@linux.vnet.ibm.com>
Cc: linux-i2c@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, devicetree <devicetree@vger.kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Mark Rutland <mark.rutland@arm.com>, Greg KH <gregkh@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, Andy Shevchenko <andy.shevchenko@gmail.com>, Peter Rosin <peda@axentia.se>
List-Id: linux-i2c@vger.kernel.org

On 18 July 2018 at 01:01, Eddie James <eajames@linux.vnet.ibm.com> wrote:
> From: "eajames@linux.vnet.ibm.com" <eajames@linux.vnet.ibm.com>
>
> Signed-off-by: Eddie James <eajames@linux.vnet.ibm.com>

Acked-by: Joel Stanley <joel@jms.id.au>


> ---
>  MAINTAINERS | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index fcefb7a..613fd52 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5917,6 +5917,14 @@ F:       fs/crypto/
>  F:     include/linux/fscrypt*.h
>  F:     Documentation/filesystems/fscrypt.rst
>
> +FSI-ATTACHED I2C DRIVER
> +M:     Eddie James <eajames@linux.vnet.ibm.com>
> +L:     linux-i2c@vger.kernel.org
> +L:     openbmc@lists.ozlabs.org (moderated for non-subscribers)
> +S:     Maintained
> +F:     drivers/i2c/busses/i2c-fsi.c
> +F:     Documentation/devicetree/bindings/i2c/i2c-fsi.txt
> +
>  FSNOTIFY: FILESYSTEM NOTIFICATION INFRASTRUCTURE
>  M:     Jan Kara <jack@suse.cz>
>  R:     Amir Goldstein <amir73il@gmail.com>
> --
> 1.8.3.1
>
