From: Abhishek Sahu <absahu@codeaurora.org>
Subject: Re: [PATCH 09/12] i2c: qup: fix buffer overflow for multiple msg of
 maximum xfer len
Date: Mon, 12 Mar 2018 17:58:11 +0530
Message-ID: <7a25bcc7cc8b29b3a92cdb1088c556c3@codeaurora.org>
References: <1517644697-30806-1-git-send-email-absahu@codeaurora.org>
 <1517644697-30806-10-git-send-email-absahu@codeaurora.org>
 <20180227231559.GJ20901@hector.attlocal.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180227231559.GJ20901@hector.attlocal.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Gross <andy.gross@linaro.org>
Cc: Wolfram Sang <wsa@the-dreams.de>, David Brown <david.brown@linaro.org>, Sricharan R <sricharan@codeaurora.org>, linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On 2018-02-28 04:45, Andy Gross wrote:
> On Sat, Feb 03, 2018 at 01:28:14PM +0530, Abhishek Sahu wrote:
>> The BAM mode requires buffer for start tag data and tx, rx SG
>> list. Currently, this is being taken for maximum transfer length
>> (65K). But an I2C transfer can have multiple messages and each
>> message can be of this maximum length so the buffer overflow will
>> happen in this case. Since increasing buffer length won’t be
>> feasible since an I2C transfer can contain any number of messages
>> so this patch does following changes to make i2c transfers working
>> for multiple messages case.
>> 
>> 1. Calculate the required buffers for 2 maximum length messages
>>    (65K * 2).
>> 2. Split the descriptor formation and descriptor scheduling.
>>    The idea is to fit as many messages in one DMA transfers for 65K
>>    threshold value (max_xfer_sg_len). Whenever the sg_cnt is
>>    crossing this, then schedule the BAM transfer and subsequent
>>    transfer will again start from zero.
>> 
>> Signed-off-by: Abhishek Sahu <absahu@codeaurora.org>
> 
> I'm ok with this patch.  I find the idea of a > 64k size message to be 
> something
> that usually wouldn't be encountered, but... with some eeproms and 
> maybe TPMs
> perhaps this could happen?
> 
> Reviewed-by: Andy Gross <andy.gross@linaro.org>

  Thanks Andy for reviewing this patch.

  There are EEPROM available with 1MB size like AT24CM01 in which we can 
read
  complete flash (128 KB) in single go by one transfer with 2 read 
messages of
  64KB.

  Thanks,
  Abhishek
