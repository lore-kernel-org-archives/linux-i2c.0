From: "Adamski, Krzysztof (Nokia - PL/Wroclaw)"
        <krzysztof.adamski@nokia.com>
Subject: Re: [PATCH] hwmon: pmbus: protect read-modify-write with lock
Date: Mon, 10 Jun 2019 06:36:46 +0000
Message-ID: <20190610063639.GA18981@localhost.localdomain>
References: <20190528090746.GA31184@localhost.localdomain>
 <20190607223217.GE869@kunai>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190607223217.GE869@kunai>
Content-Language: en-US
Content-ID: <405DED71A7499E42BD0DDDC2705F4D70@eurprd07.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

On Sat, Jun 08, 2019 at 12:32:18AM +0200, Wolfram Sang wrote:
>On Tue, May 28, 2019 at 09:08:21AM +0000, Adamski, Krzysztof (Nokia - PL/W=
roclaw) wrote:
>> The operation done in the pmbus_update_fan() function is a
>> read-modify-write operation but it lacks any kind of lock protection
>> which may cause problems if run more than once simultaneously. This
>> patch uses an existing update_lock mutex to fix this problem.
>>
>> Signed-off-by: Krzysztof Adamski <krzysztof.adamski@nokia.com>
>
>Please use get_maintainer to find the people responsible for this file.
>It is not my realm.
>
>> +out:
>> +	mutex_lock(&data->update_lock);
>
>Despite the above, have you tested the code? This likely should be
>mutex_unlock?
>

Sorry for that, I made a mistake and used wrong command to generate the
patch and send it to the wrong list of people. You can ignore this
patchset, it was resent to the proper mailing list instead.

Krzysztof
