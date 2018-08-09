From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v4 4/4] i2c: Add multi-instantiate pseudo driver
Date: Thu, 9 Aug 2018 11:15:49 +0200
Message-ID: <06718a13-8c68-e74f-df4c-64b9a928bdd4@redhat.com>
References: <20180808083006.31919-1-hdegoede@redhat.com>
 <20180808083006.31919-5-hdegoede@redhat.com>
 <20180808170014.izjkviwh67hfu3hz@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180808170014.izjkviwh67hfu3hz@ninjato>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Darren Hart <dvhart@infradead.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, Heikki Krogerus <heikki.krogerus@linux.intel.com>, John Garry <john.garry@huawei.com>, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Hi,

On 08-08-18 19:00, Wolfram Sang wrote:
> 
> $subject still says "i2c:"

Ah, good point I will send a v5 with this fixed, I will also
do s/no_clients/num_clients/ for v5 as Andy requested.

Regards,

Hans
