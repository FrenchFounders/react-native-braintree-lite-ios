using ReactNative.Bridge;
using System;
using System.Collections.Generic;
using Windows.ApplicationModel.Core;
using Windows.UI.Core;

namespace Braintree.Lite.RNBraintreeLite
{
    /// <summary>
    /// A module that allows JS to share data.
    /// </summary>
    class RNBraintreeLiteModule : NativeModuleBase
    {
        /// <summary>
        /// Instantiates the <see cref="RNBraintreeLiteModule"/>.
        /// </summary>
        internal RNBraintreeLiteModule()
        {

        }

        /// <summary>
        /// The name of the native module.
        /// </summary>
        public override string Name
        {
            get
            {
                return "RNBraintreeLite";
            }
        }
    }
}
