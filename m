From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v9 5/6] i2c: designware: add SLAVE mode functions
Date: Mon, 22 May 2017 19:37:54 +0300
Message-ID: <CAHp75VesAMbxViEDDa7sTkufDKJgnX23y2L=SM968rFSsFtiDQ@mail.gmail.com>
References: <cover.1493893241.git.lolivei@synopsys.com> <b2accd73182d19927dfb0cd1a57cadf469ae5e9d.1493893241.git.lolivei@synopsys.com>
 <1494262399.30052.69.camel@linux.intel.com> <513c9c43-cf3b-3aa9-b5c2-99932527bf19@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-qt0-f181.google.com ([209.85.216.181]:36069 "EHLO
        mail-qt0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934440AbdEVQiA (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Mon, 22 May 2017 12:38:00 -0400
In-Reply-To: <513c9c43-cf3b-3aa9-b5c2-99932527bf19@synopsys.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Luis Oliveira <Luis.Oliveira@synopsys.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-i2c@vger.kernel.org, devicetree <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Ramiro Oliveira <Ramiro.Oliveira@synopsys.com>, Joao Pinto <Joao.Pinto@synopsys.com>, CARLOS.PALMINHA@synopsys.com

On Mon, May 22, 2017 at 5:32 PM, Luis Oliveira
<Luis.Oliveira@synopsys.com> wrote:
> On 08-May-17 17:53, Andy Shevchenko wrote:
>> On Mon, 2017-05-08 at 11:37 +0100, Luis Oliveira wrote:

>>> +            enabled, slave_activity, raw_stat, stat);
>>> +
>>
>>> +    if (slave_activity) {
>>> +            if (stat & DW_IC_INTR_RD_REQ) {
>>
>> Looking into next condition (stat & DW_IC_INTR_RX_DONE) I would
>> exchange these lines
>>
>
> By order? I don't think I understood your point. Please elaborate a little more.

if (stat & DW_IC_INTR_RD_REQ) {
  if (slave_activity) {

And perhaps refactor function a bit.

-- 
With Best Regards,
Andy Shevchenko
