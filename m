From: Vlad Tsyrklevich <vlad@tsyrklevich.net>
Subject: Re: [PATCH] drivers/i2c/i2c-dev: Fix kernel memory disclosure
Date: Mon, 9 Jan 2017 17:19:23 +0700
Message-ID: <CAH0z3hP9NRf87WNmtQjXKW7u5ZN=0rcwUWBJvHGFeSywRNvUOQ@mail.gmail.com>
References: <1476190348-37589-1-git-send-email-vlad@tsyrklevich.net> <20161025094512.GF1597@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-ua0-f194.google.com ([209.85.217.194]:34403 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758475AbdAIKTY (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Mon, 9 Jan 2017 05:19:24 -0500
Received: by mail-ua0-f194.google.com with SMTP id i68so49233997uad.1
        for <linux-i2c@vger.kernel.org>; Mon, 09 Jan 2017 02:19:24 -0800 (PST)
In-Reply-To: <20161025094512.GF1597@katana>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org

I apologize for the long delay, this reply got lost in my inbox. I've
added an updated patch below:

i2c_smbus_xfer() does not always fill an entire block, allowing
kernel stack memory disclosure through the temp variable. Clear
it before it's read to.

Signed-off-by: Vlad Tsyrklevich <vlad@tsyrklevich.net>

---
 drivers/i2c/i2c-dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/i2c-dev.c b/drivers/i2c/i2c-dev.c
index 66f323f..6f638bb 100644
--- a/drivers/i2c/i2c-dev.c
+++ b/drivers/i2c/i2c-dev.c
@@ -331,7 +331,7 @@ static noinline int i2cdev_ioctl_smbus(struct
i2c_client *client,
    unsigned long arg)
 {
  struct i2c_smbus_ioctl_data data_arg;
- union i2c_smbus_data temp;
+ union i2c_smbus_data temp = {};
  int datasize, res;

  if (copy_from_user(&data_arg,

On Tue, Oct 25, 2016 at 4:45 PM, Wolfram Sang <wsa@the-dreams.de> wrote:
> On Tue, Oct 11, 2016 at 02:52:28PM +0200, Vlad Tsyrklevich wrote:
>> i2c_smbus_xfer() does not always fill an entire block, allowing
>> kernel stack memory disclosure through the temp variable. Clear
>> it before it's read to.
>>
>> Signed-off-by: Vlad Tsyrklevich <vlad@tsyrklevich.net>
>
> Yes, thanks. But what about clearing 'temp' when it is declared? This
> would be rock-solid for all future code paths.
>
>>
>> ---
>>  drivers/i2c/i2c-dev.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/i2c/i2c-dev.c b/drivers/i2c/i2c-dev.c
>> index 66f323f..62cb111 100644
>> --- a/drivers/i2c/i2c-dev.c
>> +++ b/drivers/i2c/i2c-dev.c
>> @@ -393,6 +393,8 @@ static noinline int i2cdev_ioctl_smbus(struct i2c_client *client,
>>           (data_arg.read_write == I2C_SMBUS_WRITE)) {
>>               if (copy_from_user(&temp, data_arg.data, datasize))
>>                       return -EFAULT;
>> +     } else {
>> +             memset(&temp, 0, datasize);
>>       }
>>       if (data_arg.size == I2C_SMBUS_I2C_BLOCK_BROKEN) {
>>               /* Convert old I2C block commands to the new
>> --
>> 2.7.0
>>
