From: Michael Hennerich <michael.hennerich@analog.com>
Subject: Re: question about concurrent regmap i2c usage
Date: Wed, 5 Apr 2017 08:31:15 +0200
Message-ID: <4929e112-9a08-8b9c-f64e-fd2ffaf8b45e@analog.com>
References: <76471664-425b-c386-3ad8-efeabc2eaf7e@analog.com>
 <20170404122654.dfhtvpcnngl3gfco@sirena.org.uk>
Reply-To: <michael.hennerich@analog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <20170404122654.dfhtvpcnngl3gfco@sirena.org.uk>
Sender: linux-gpio-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: linus.walleij@linaro.org, wsa@the-dreams.de, linux-gpio@vger.kernel.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On 04.04.2017 14:26, Mark Brown wrote:
> On Tue, Apr 04, 2017 at 10:28:23AM +0200, Michael Hennerich wrote:
>
>> A question came up, regarding whether it's recommended to mix regmap_i2c and
>> plain i2c_smbus or direct adapter transfers.
>
>> In this specific case for the i2c MUX portion we need to avoid double locks,
>> and therefore use un-locked direct adapter transfers.
>
>> The same time we also implement a small gpiochip, where we would like to use
>> regmap to avoid some boilerplate code for the register cache.
>
> That should work fine providing nothing tries to change cached registers
> underneath the regmap.  regmap won't be able to tell anything's changed
> otherwise.

Hi Mark,

Thanks for confirmation!

-- 
Greetings,
Michael

--
Analog Devices GmbH      Otl-Aicher Strasse 60-64      80807 München
Sitz der Gesellschaft München, Registergericht München HRB 40368,
Geschäftsführer: Peter Kolberg, Ali Raza Husain, Eileen Wynne
