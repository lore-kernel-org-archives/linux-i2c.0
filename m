From: "Ivan T. Ivanov" <iivanov@mm-sol.com>
Subject: Re: [PATCH V4 2/7] qup: i2c: factor out common code for reuse
Date: Mon, 20 Jul 2015 11:25:00 +0300
Message-ID: <1437380700.6267.1.camel@mm-sol.com>
References: <1436412350-19519-1-git-send-email-sricharan@codeaurora.org>
	 <1436412350-19519-3-git-send-email-sricharan@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1436412350-19519-3-git-send-email-sricharan@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sricharan R <sricharan@codeaurora.org>
Cc: devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, galak@codeaurora.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, agross@codeaurora.org, dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org


Hi Sricharan, 

On Thu, 2015-07-09 at 08:55 +0530, Sricharan R wrote:
> 

>  static int qup_i2c_read_one(struct qup_i2c_dev *qup, struct i2c_msg *msg)
>  {
> -       unsigned long left;
> -       int ret;
> +       int ret = 0;
> 
> -       qup->msg = msg;
> -       qup->pos  = 0;
> +       /*
> +               * The QUP block will issue a NACK and STOP on the bus when reaching
> +               * the end of the read, the length of the read is specified as one byte
> +               * which limits the possible read to 256 (QUP_READ_LIMIT) bytes.
> +               */
> +       if (msg->len > QUP_READ_LIMIT) {
> +               dev_err(qup->dev, "HW not capable of reads over %d bytes\n",
> +                       QUP_READ_LIMIT);
> +               return -EINVAL;
> +       }
> 

This should be removed. Please see qup_i2c_quirks.

Regards,
Ivan
