From: =?ISO-8859-1?Q?H=E5vard_Skinnemoen?= <hskinnemoen@gmail.com>
Subject: Re: [PATCH] i2c-gpio: add devicetree support
Date: Wed, 2 Feb 2011 20:24:06 -0800
Message-ID: <AANLkTinOZxbuZ7EpG6uT3vJdY_9LwgEg5G30_M4TEceA@mail.gmail.com>
References: <AANLkTimoaJKy-WTTHmRXFMmM6=e7uvzhjwRcDtNqGAPj@mail.gmail.com>
	<1296699980-30234-1-git-send-email-thomas@wytron.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1296699980-30234-1-git-send-email-thomas@wytron.com.tw>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Chou <thomas@wytron.com.tw>
Cc: Grant Likely <grant.likely@secretlab.ca>, Ben Dooks <ben-linux@fluff.org>, linux-kernel@vger.kernel.org, nios2-dev@sopc.et.ntust.edu.tw, devicetree-discuss@lists.ozlabs.org, linux-i2c@vger.kernel.org, Jean Delvare <khali@linux-fr.org>, Albert Herranz <albert_herranz@yahoo.es>
List-Id: linux-i2c@vger.kernel.org

On Wed, Feb 2, 2011 at 6:26 PM, Thomas Chou <thomas@wytron.com.tw> wrote:
> This patch adds devicetree support to i2c-gpio driver. It converts
> dts bindings and allocates a struct i2c_gpio_platform_data, which
> will be freed on driver removal.
>
> Signed-off-by: Albert Herranz <albert_herranz@yahoo.es>
> Signed-off-by: Thomas Chou <thomas@wytron.com.tw>

Acked-by: Haavard Skinnemoen <hskinnemoen@gmail.com>
