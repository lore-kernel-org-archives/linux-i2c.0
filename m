From: rajeev kumar <rajeevkumar.linux@gmail.com>
Subject: Re: [PATCH v3 2/2] i2c: qup: support SMBus block read
Date: Wed, 25 May 2016 15:01:29 +0530
Message-ID: <CAA7nrtgAh6EDJO_qTgMawE=tpZe6F_Ae1G0OhuUME0QF4W5AJA@mail.gmail.com>
References: <1463694268-9473-1-git-send-email-austinwc@codeaurora.org>
	<1463694268-9473-2-git-send-email-austinwc@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-lf0-f66.google.com ([209.85.215.66]:33611 "EHLO
	mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752942AbcEYJbc (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Wed, 25 May 2016 05:31:32 -0400
In-Reply-To: <1463694268-9473-2-git-send-email-austinwc@codeaurora.org>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Austin Christ <austinwc@codeaurora.org>
Cc: nkaje@codeaurora.org, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-arm-msm@vger.kernel.org, rruigrok@codeaurora.org, timur@codeaurora.org, cov@codeaurora.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Fri, May 20, 2016 at 3:14 AM, Austin Christ <austinwc@codeaurora.org> wrote:
> From: Naveen Kaje <nkaje@codeaurora.org>
>
> I2C QUP driver relies on SMBus emulation support from the framework.
> To handle SMBus block reads, the driver should check I2C_M_RECV_LEN
> flag and should read the first byte received as the message length.
>
> The driver configures the QUP hardware to read one byte. Once the
> message length is known from this byte, the QUP hardware is configured
> to read the rest.
>
> Signed-off-by: Naveen Kaje <nkaje@codeaurora.org>
> Signed-off-by: Austin Christ <austinwc@codeaurora.org>
> ---
>  drivers/i2c/busses/i2c-qup.c | 68 ++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 65 insertions(+), 3 deletions(-)
>
> Changes:
> - v3:
>  - clean up redundant checks
>  - use constant instead of variable for smbus length field
> - v2:
>  - rework the smbus block read and break into separate function
>
> diff --git a/drivers/i2c/busses/i2c-qup.c b/drivers/i2c/busses/i2c-qup.c
> index ea6ca5f..9fbed83 100644
> --- a/drivers/i2c/busses/i2c-qup.c
> +++ b/drivers/i2c/busses/i2c-qup.c
> @@ -517,6 +517,33 @@ static int qup_i2c_get_data_len(struct qup_i2c_dev *qup)
>         return data_len;
>  }
>
> +static bool qup_i2c_check_msg_len(struct i2c_msg *msg)
> +{
> +       return ((msg->flags & I2C_M_RD) && (msg->flags & I2C_M_RECV_LEN));
> +}
> +
> +static int qup_i2c_set_tags_smb(u16 addr, u8 *tags, struct qup_i2c_dev *qup,
> +                       struct i2c_msg *msg)
> +{
> +       int len = 0;
> +
> +       if (msg->len > 1) {
> +               tags[len++] = QUP_TAG_V2_DATARD_STOP;
> +               tags[len++] = qup_i2c_get_data_len(qup) - 1;
> +       } else {
> +               tags[len++] = QUP_TAG_V2_START;
> +               tags[len++] = addr & 0xff;
> +
> +               if (msg->flags & I2C_M_TEN)
> +                       tags[len++] = addr >> 8;
> +
> +               tags[len++] = QUP_TAG_V2_DATARD;
> +               /* Read 1 byte indicating the length of the SMBus message */
> +               tags[len++] = 1;
> +       }
> +       return len;
> +}
> +
>  static int qup_i2c_set_tags(u8 *tags, struct qup_i2c_dev *qup,
>                             struct i2c_msg *msg,  int is_dma)
>  {
> @@ -526,6 +553,10 @@ static int qup_i2c_set_tags(u8 *tags, struct qup_i2c_dev *qup,
>
>         int last = (qup->blk.pos == (qup->blk.count - 1)) && (qup->is_last);
>
> +       /* Handle tags for SMBus block read */
> +       if (qup_i2c_check_msg_len(msg))
> +               return qup_i2c_set_tags_smb(addr, tags, qup, msg);
> +
>         if (qup->blk.pos == 0) {
>                 tags[len++] = QUP_TAG_V2_START;
>                 tags[len++] = addr & 0xff;
> @@ -1065,9 +1096,17 @@ static int qup_i2c_read_fifo_v2(struct qup_i2c_dev *qup,
>                                 struct i2c_msg *msg)
>  {
>         u32 val;
> -       int idx, pos = 0, ret = 0, total;
> +       int idx, pos = 0, ret = 0, total, msg_offset = 0;
>
> +       /*
> +        * If the message length is already read in
> +        * the first byte of the buffer, account for
> +        * that by setting the offset
> +        */
> +       if (qup_i2c_check_msg_len(msg) && (msg->len > 1))
> +               msg_offset = 1;
>         total = qup_i2c_get_data_len(qup);
> +       total -= msg_offset;
>
>         /* 2 extra bytes for read tags */
>         while (pos < (total + 2)) {
> @@ -1087,8 +1126,8 @@ static int qup_i2c_read_fifo_v2(struct qup_i2c_dev *qup,
>
>                         if (pos >= (total + 2))
>                                 goto out;
> -
> -                       msg->buf[qup->pos++] = val & 0xff;
> +                       msg->buf[qup->pos + msg_offset] = val & 0xff;
> +                       qup->pos++;
>                 }
>         }
>
> @@ -1128,6 +1167,24 @@ static int qup_i2c_read_one_v2(struct qup_i2c_dev *qup, struct i2c_msg *msg)
>                         goto err;
>
>                 qup->blk.pos++;
> +
> +               /* Handle SMBus block read length */
> +               if (qup_i2c_check_msg_len(msg) && (msg->len == 1)) {
> +                       if (msg->buf[0] > I2C_SMBUS_BLOCK_MAX) {
> +                               ret = -EPROTO;
> +                               goto err;
> +                       }
> +                       msg->len += msg->buf[0];
> +                       qup->pos = 0;
> +                       qup_i2c_set_read_mode_v2(qup, msg->len);
> +                       ret = qup_i2c_issue_xfer_v2(qup, msg);
> +                       if (ret)
> +                               goto err;
> +                       ret = qup_i2c_wait_for_complete(qup, msg);
> +                       if (ret)
> +                               goto err;
> +                       qup_i2c_set_blk_data(qup, msg);
> +               }
>         } while (qup->blk.pos < qup->blk.count);
>
>  err:
> @@ -1210,6 +1267,11 @@ static int qup_i2c_xfer(struct i2c_adapter *adap,
>                         goto out;
>                 }
>
> +               if (qup_i2c_check_msg_len(&msgs[idx])) {
> +                       ret = -EOPNOTSUPP;

Could you please rethink on this return value ? It should not be "EOPNOTSUPP"

~Rajeev

> +                       goto out;
> +               }
> +
>                 if (msgs[idx].flags & I2C_M_RD)
>                         ret = qup_i2c_read_one(qup, &msgs[idx]);
>                 else
> --
> Qualcomm Innovation Center, Inc.
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project.
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
