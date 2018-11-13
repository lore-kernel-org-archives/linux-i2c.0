From: vitor <vitor.soares@synopsys.com>
Subject: Re: [PATCH v3 2/3] dt-bindings: i3c: Document Synopsys DesignWare I3C
 master bindings
Date: Tue, 13 Nov 2018 11:20:15 +0000
Message-ID: <ec1059fa-420e-ee18-1831-170904c0ccd0@synopsys.com>
References: <1541697251-20392-1-git-send-email-soares@synopsys.com>
 <1541697251-20392-3-git-send-email-soares@synopsys.com>
 <20181113020957.GA31668@bogus>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181113020957.GA31668@bogus>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>, Vitor soares <vitor.soares@synopsys.com>
Cc: boris.brezillon@bootlin.com, wsa@the-dreams.de, linux-i2c@vger.kernel.org, corbet@lwn.net, linux-doc@vger.kernel.org, gregkh@linuxfoundation.org, arnd@arndb.de, psroka@cadence.com, agolec@cadence.com, adouglas@cadence.com, bfolta@cadence.com, dkos@cadence.com, alicja@cadence.com, cwronka@cadence.com, sureshp@cadence.com, rafalc@cadence.com, thomas.petazzoni@bootlin.com, nm@ti.com, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, geert@linux-m68k.org, linus.walleij@linaro.org, Xiang.Lin@synaptics.com, linux-gpio@vger.kernel.org, nsekhar@ti.com, pgaj@cadence.com, peda@axentia.se, mshettel@codeaurora.org, swboyd@chromi
List-Id: linux-i2c@vger.kernel.org

Hi Rob,

On 13/11/18 02:09, Rob Herring wrote:
> On Thu, Nov 08, 2018 at 05:14:10PM +0000, Vitor soares wrote:
>> Document Synopsys DesignWare I3C master module
>>
>> Signed-off-by: Vitor soares <soares@synopsys.com>
> Please make your author and S-o-b emails match.

This is an alias and both email will work. Anyway I agree that should be 
the same that appear in the mailing list and I will change it.

>> ---
>> Changes in v3:
>> - Remove dummy characters
>>
>> Changes in v2:
>> - Address the changes in Documentation/devicetree/bindings/i3c/i3c.txt
>> - Add controller version on compatible string
>>
>>   .../devicetree/bindings/i3c/snps,dw-i3c-master.txt | 42 ++++++++++++++++++++++
>>   1 file changed, 42 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/i3c/snps,dw-i3c-master.txt
> Otherwise,
>
> Reviewed-by: Rob Herring <robh@kernel.org>

Thanks for review.


Best regards,

Vitor Soares
