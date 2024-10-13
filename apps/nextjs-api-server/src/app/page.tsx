"use client";
import Image from "next/image";
import Mockup from "../app/images/mockuper.png";

const Home = () => {
  return (
    <div>
      {/* About Section */}
      <section id="about" className="container mx-auto py-5 px-6">
        <div className="flex flex-col md:flex-row items-center gap-8">
          <div className="md:w-1/2 w-full">
            <h2 className="text-4xl font-bold text-blue-600 mb-4">
              What is SwiftX?
            </h2>
            <p className="text-gray-700 mb-6">
              SwiftX is a dual-ledger-based SWIFT extension designed for
              enterprise-grade cross-border payments. It enables individuals and
              businesses to make instant payouts by using blockchain tokens as
              guarantees in a pledge model, allowing receiving partners to pay
              out funds instantly before traditional settlement is completed.
              SwiftX offers enhanced speed, reliability, and compliance with
              global financial regulations, making it a scalable solution ready
              for integration. Its unique approach reduces settlement times
              compared to conventional SWIFT systems, ensuring seamless and
              efficient financial transactions.
            </p>
            <ul className="list-disc list-inside space-y-2 text-gray-600">
              <li>Dual Ledger</li>
              <li>Token as Guarantee</li>
              <li>Pledge Model</li>
              <li>On-Chain directed Settlements</li>
            </ul>
            <div className="flex gap-4 mt-8">
              <a href="/dashboard">
                <button className="bg-blue-600 text-white px-6 py-3 rounded-lg hover:bg-blue-700 transition-colors duration-300">
                  Go to Dashboard
                </button>
              </a>
              <a href="#download">
                <button className="bg-white text-blue-600 px-6 py-3 rounded-lg hover:bg-gray-200 transition-colors duration-300">
                  Download Now
                </button>
              </a>
            </div>
          </div>
          <div className="md:w-1/2 w-full">
            <Image
              src={Mockup}
              alt="SwiftX Features"
              width={100}
              height={100}
              layout="responsive"
              className="rounded-lg"
            />
          </div>
        </div>
      </section>

      {/* Download Section */}
      <section id="download" className="bg-blue-600 text-white py-20 px-6">
        <div className="container mx-auto text-center max-w-xl">
          <h2 className="text-4xl font-bold mb-4">Get SwiftX Today</h2>
          <p className="text-white mb-8">
            Start experiencing faster, easier, and more secure international
            transactions. Download the SwiftX app now and join thousands of
            users worldwide.
          </p>
          <div className="flex justify-center">
            <a
              href="https://github.com/Code-Decoders/swiftx-monorepo/releases/download/app/app-release.apk"
              className="inline-block"
            >
              <button className="bg-white text-blue-600 px-6 py-3 rounded-lg hover:bg-gray-200 transition-colors duration-300">
                Download Now
              </button>
            </a>
          </div>
        </div>
      </section>

      {/* Footer */}
      <footer className="bg-gray-800 text-white py-4">
        <div className="container mx-auto text-center">
          <p className="text-sm">
            &copy; {new Date().getFullYear()} SwiftX. All rights reserved.
          </p>
          <p className="text-sm">
            Developed by{" "}
            <a
              href="https://codedecoders.io"
              className="text-blue-500 hover:underline"
            >
              Code Decoders
            </a>
          </p>
        </div>
      </footer>
    </div>
  );
};

export default Home;
